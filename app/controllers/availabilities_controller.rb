class AvailabilitiesController < ApplicationController
  def unavailable
    if current_tenant.nil?
      render 'missing_data'
    else
      render 'transactions_in_progress'
    end
  end

  def status
    render json: { locked_tenant: locked_tenant? }
  end

  protected

  def locked_tenant?
    current_tenant.nil? ? false : current_tenant.locked?
  end
end
