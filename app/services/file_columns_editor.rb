class FileColumnsEditor < FileEditor
  attr_reader :errors

  def initialize(file, transaction, errors)
    @file = file
    @transaction = transaction
    @errors = errors
  end

  def call
    file_setup
    fill_with_data
    add_errors_column
    fill_errors
    file_save
  end

  private

  def fill_with_data
    row_count = file.last_row
    for i in 1..row_count
      file.row(i).each_with_index do |elem, j|
        worksheet.write(i-1, j, elem)
      end
    end
  end

  def fill_errors
    column_count = file.last_column
    messages = errors.join("\n")
    worksheet.write(1, column_count, messages)
  end
end
