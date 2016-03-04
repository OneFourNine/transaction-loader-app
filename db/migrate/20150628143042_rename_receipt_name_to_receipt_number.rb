class RenameReceiptNameToReceiptNumber < ActiveRecord::Migration
  def change
    rename_column :file_transactions, :receipt_name, :receipt_number
  end
end
