class Transaction < ActiveRecord::Base
  mount_uploader :excel_file, ExcelFileUploader

  attr_reader :excel_file_cache

  validates :excel_file, presence: true, file_size: { less_than_or_equal_to: 5.megabytes }
  validate :excel_file_rows_count, if: :file_uploaded?

  has_many :file_transactions, dependent: :destroy
  has_many :imported_file_transactions, -> { where(imported: true) }, class_name: 'FileTransaction'

  def to_param
    uuid
  end

  def file_uploaded?
    excel_file.file.try(:exists?)
  end

  def modified_file_path
    filename = excel_file_identifier.split('.').first
    location = Rails.root.to_s + '/public' + excel_file.url.split('/')[0..-2].join('/')
    location + '/modified_' + filename + '.xls'
  end

  def successful_transactions
    file_transactions.select(&:successful?)
  end

  def failure_transactions
    file_transactions.select(&:failure?)
  end

  def download_file_path
    modified_file_path
  end

  def cleanup_performed?
    !File.exist?(download_file_path)
  end

  def excel_file_rows_count
    if RowsCounter.new(excel_file.current_path).size > 10_000
      errors.add(:excel_file, 'with more than 10 000 lines is not allowed')
    end
  end
end
