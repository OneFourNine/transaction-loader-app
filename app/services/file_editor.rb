class FileEditor
  attr_reader :file, :transaction, :worksheet, :workbook

  def initialize(file, transaction)
    @file = file
    @transaction = transaction
  end

  private

  def file_setup
    new_workbook
    new_worksheet
  end

  def new_workbook
    @workbook ||= WriteExcel.new(file_location)
  end

  def new_worksheet
    @worksheet ||= workbook.add_worksheet
  end

  def filename
    transaction.excel_file_identifier.split('.').first
  end

  def file_location
    original_file_location + '/modified_' + filename + '.xls'
  end

  def original_file_location
    Rails.root.to_s + '/public' + transaction.excel_file.url.split('/')[0..-2].join('/')
  end

  def add_errors_column
    column_count = file.last_column
    worksheet.write(0, column_count, 'Error message')
  end

  def file_save
    workbook.close
    workbook
  end
end
