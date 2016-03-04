class FileTransactionsSetup
  include Helpers::Excel

  attr_reader :transaction, :file_path, :valid, :column_errors

  def initialize(transaction)
    @transaction = transaction
    @file_path = transaction.excel_file.current_path
    @valid = true
  end

  def call
    @valid = false unless both_validations_passed?
    self
  end

  def all_validations_passed?
    valid
  end

  private

  def gathered_transactions
    TransactionsReader.new(opened_file, transaction).call
  end

  def columns_validator
    @validator ||= ColumnsValidator.new(first_row)
  end

  def validate_columns
    columns_validator.valid?
  end

  def validate_transactions
    if TransactionsValidator.new(gathered_transactions).valid?
      true
    else
      FileRowsEditor.new(opened_file, transaction).call
      false
    end
  end

  def both_validations_passed?
    if validate_columns
      validate_transactions
    else
      FileColumnsEditor.new(opened_file, transaction, columns_validator.errors).call
      false
    end
  end
end
