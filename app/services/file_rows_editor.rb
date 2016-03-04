class FileRowsEditor < FileEditor
  attr_accessor :mambu_api_called

  def initialize(file, transaction, mambu_api_called = false)
    @file = file
    @transaction = transaction
    @mambu_api_called = mambu_api_called
  end

  def call
    file_setup
    add_columns
    fill_with_transactions
    file_save
  end

  private

  def add_columns
    column_names.each_with_index do |val, i|
      worksheet.write(0, i, val)
    end
    worksheet.write(0, 13, 'Status')
  end

  def fill_with_transactions
    transaction.file_transactions.reverse_each.with_index(1) do |val, i|
      worksheet.write(i, 0, val.account)
      worksheet.write(i, 1, val.amount)
      worksheet.write(i, 2, format_date(val.date))
      worksheet.write(i, 3, val.reference)
      worksheet.write(i, 4, val.t_type)
      worksheet.write(i, 5, val.transaction_channel)
      worksheet.write(i, 6, val.identifier)
      worksheet.write(i, 7, val.account_name)
      worksheet.write(i, 8, val.receipt_number)
      worksheet.write(i, 9, val.bank_number)
      worksheet.write(i, 10, val.check_number)
      worksheet.write(i, 11, val.bank_account_number)
      worksheet.write(i, 12, val.bank_routing_number)
      worksheet.write(i, 13, format_errors(val))
    end
  end

  def column_names
    names = FileTransaction::COLUMN_NAMES.clone
    names[2] = 'Date'
    names
  end

  def format_errors(file_transaction)
    return validation_errors(file_transaction) unless mambu_api_called
    return api_errors(file_transaction) if file_transaction.mambu_error.present?
    api_infos(file_transaction)
  end

  def validation_errors(file_transaction)
    file_transaction.errors.full_messages.join(', ')
  end

  def api_errors(file_transaction)
    return '' unless error = file_transaction.mambu_error

    "#{error.message}, code: #{error.code}"
  end

  def api_infos(file_transaction)
    return '' unless info = file_transaction.mambu_info
    info.message
  end

  def format_date(date)
    date.try(:strftime, '%d.%m.%Y')
  end
end
