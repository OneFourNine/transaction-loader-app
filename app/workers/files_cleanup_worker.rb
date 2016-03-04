class FilesCleanupWorker
  include Sidekiq::Worker

  def perform(transaction_id)
    if transaction = Transaction.find(transaction_id)
      File.delete(transaction.excel_file.current_path) if transaction.excel_file.file.exists?
      File.delete(transaction.modified_file_path) if transaction.modified_file_exists?
    end
  end
end
