class AddImportedToFileTransactions < ActiveRecord::Migration
  def change
    add_column :file_transactions, :imported, :boolean, default: false
  end
end
