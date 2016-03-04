module Helpers
  module Excel
    def spreadsheet
      if file_extension == 'xlsx'
        @spreadsheets ||= Roo::Excelx.new(file_path)
      else
        @spreadsheets ||= Roo::Excel.new(file_path)
      end
    end

    def opened_file
      spreadsheet.sheet(0)
    end

    def first_row
      spreadsheet.sheet(0).row(1)
    end

    def file_extension
      file_path.split('.').last
    end
  end
end
