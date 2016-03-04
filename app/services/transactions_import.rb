class TransactionsImport
  include Helpers::Excel

  attr_reader :transaction, :file_path, :connection, :connection

  def initialize(transaction, connection)
    @transaction = transaction
    @connection = connection
    @file_path = transaction.excel_file.current_path
  end

  def call
    process_transactions
  end

  private

  def process_transactions
    transaction.file_transactions.reverse_each do |item|
      begin
        Mambu::Savings.create_deposit(item.account, connection, data(item))
        item.create_mambu_info(message: 'SUCCESSFULLY PROCESSED')
        item.update(imported: true)
      rescue Mambu::Error => e
        item.create_mambu_error(message: e.status, code: e.code)
      end
    end

    update_file_with_status
  end

  def data(item)
    values = item.hasherize
    values[:type] = values.delete(:t_type).upcase
    values[:date] = values[:date].to_time.iso8601[0..-7] if values[:date]
    values[:method] = values.delete(:transaction_channel)
    values
  end

  def update_file_with_status
    FileRowsEditor.new(opened_file, transaction, true).call
  end
end
