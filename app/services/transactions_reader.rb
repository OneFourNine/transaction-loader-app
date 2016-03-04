class TransactionsReader
  attr_reader :file, :transaction

  def initialize(file, transaction)
    @file = file
    @transaction = transaction
  end

  def call
    bulk_import
  end

  private

  def bulk_import
    rows_count = file.last_row

    for i in 2..rows_count
      f_transaction = FileTransaction.new(
        account:             file.cell(i, 1),
        amount:              file.cell(i, 2),
        date:                parse_date(file.cell(i, 3)),
        reference:           file.cell(i, 4),
        t_type:              file.cell(i, 5),
        transaction_channel: file.cell(i, 6),
        identifier:          file.cell(i, 7),
        account_name:        file.cell(i, 8),
        receipt_number:      file.cell(i, 9),
        bank_number:         file.cell(i, 10),
        check_number:        file.cell(i, 11),
        bank_account_number: file.cell(i, 12),
        bank_routing_number: file.cell(i, 13)
      )

      transaction.file_transactions << f_transaction
    end

    transaction.file_transactions
  end

  def parse_date(value)
    date = Time.parse(value.to_s)
  rescue ArgumentError, TypeError
    nil
  else
    date
  end
end
