class AddReferenceToTransaction < ActiveRecord::Migration
  def change
    add_column :file_transactions, :transaction_id, :integer
    add_index :file_transactions, :transaction_id
  end
end
