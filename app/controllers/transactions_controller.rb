class TransactionsController < ApplicationController
  expose(:transaction, finder: :find_by_uuid)
  expose(:transaction_presenter) { transaction.decorate }

  before_action :availability_check
  before_action :extend_session, except: :summary
  before_action :free_tenant, only: [:index, :validation_failed, :summary]

  def create
    transaction = Transaction.new(transaction_params)

    if transaction.save
      current_tenant.lock!(current_user)
      begin
        begin_transactions_import(transaction.reload)
      rescue Rack::Timeout::RequestTimeoutException
        current_tenant.unlock!
        redirect_to timeout_transaction_path(id: transaction.id)
      end
    else
      flash.now[:error] = transaction.errors.full_messages.to_sentence
      render :index
    end
  end

  def file_download
    if transaction.cleanup_performed?
      flash[:info] = "Transaction files already removed"
      redirect_to root_url
    else
      send_file transaction.download_file_path
    end

    FilesCleanupWorker.perform_in(5.minutes, params[:id])
  end

  def start_import
    if connection = MambuConnection.new(credentials).established?
      begin
        TransactionsImport.new(transaction, connection).call
        redirect_to summary_transaction_path(transaction)
      rescue Rack::Timeout::RequestTimeoutException
        current_tenant.unlock!
        redirect_to timeout_transaction_path
      end
    else
      flash[:error] = "Invalid credentials"
      redirect_to initialize_import_transaction_path(transaction)
    end
  end

  def timeout
    @imported = imported_transactions
  end

  protected

  def imported_transactions
    transaction.imported_file_transactions.count
  end

  def begin_transactions_import(transaction)
    setup = FileTransactionsSetup.new(transaction).call

    if setup.all_validations_passed?
      redirect_to initialize_import_transaction_path(transaction)
    else
      redirect_to validation_failed_transaction_path(transaction)
    end
  end

  def credentials
    {
      password: auth_params[:password],
      user_name: auth_params[:username],
      tenant: session[:TENANT_ID]
    }
  end

  def auth_params
    params.require(:authentication).permit(:username, :password)
  end

  def transaction_params
    params.require(:transaction).permit!
  end

  def availability_check
    if current_tenant.nil? || current_tenant.locked?(current_user)
      redirect_to unavailable_path
    end
  end

  def extend_session
    if current_tenant.resident? && current_tenant.user_key == current_user
      current_tenant.update_attribute(:remaining_time, 2.hours.from_now)
    end
  end

  def free_tenant
    current_tenant.unlock!
  end
end
