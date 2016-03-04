class RenameColumnTypeInFileTransactions < ActiveRecord::Migration
  def change
    rename_column :file_transactions, :type, :t_type
  end
end
