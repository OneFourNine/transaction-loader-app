desc 'Removes all uploaded transaction files and records'
task transactions_cleanup: :environment do
  dir_path = File.join(Rails.root, 'public', 'uploads')
  FileUtils.rm_rf("#{dir_path}/.", secure: true)

  Transaction.destroy_all
end
