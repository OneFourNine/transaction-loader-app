class ColumnsValidator
  attr_reader :file_column
  attr_accessor :errors

  def initialize(file_column)
    @file_column = file_column
    @errors = []
  end

  def valid?
    validate_columns_presence
    errors.empty?
  end

  private

  def validate_columns_presence
    FileTransaction::COLUMN_NAMES.each_with_index do |name, i|
      next unless value_mismatch?(file_column[i], name, i)
      next if valid_date_column?(file_column[i], i)
      errors << error_message(file_column[i], i)
    end
  end

  def format_column(value)
    value.nil? ? 'empty cell' : value
  end

  def error_message(value, index)
    "Wrong column value - got #{format_column(value)} " +
    "expected #{FileTransaction::COLUMN_NAMES[index]}"
  end

  def value_mismatch?(file_column, name, index)
    file_column.nil? || name.casecmp(file_column) != 0
  rescue TypeError
    errors << error_message(file_column, index)
  end

  def valid_date_column?(name, index)
    index == 2 && name.casecmp('Date DD.MM.YYYY') == 0
  end
end
