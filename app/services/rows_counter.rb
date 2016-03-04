class RowsCounter
  attr_reader :file_path

  include Helpers::Excel

  def initialize(path)
    @file_path = path
  end

  def size
    opened_file.last_row
  end
end
