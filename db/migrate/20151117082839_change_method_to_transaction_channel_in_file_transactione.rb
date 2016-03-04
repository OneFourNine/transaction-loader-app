class ChangeMethodToTransactionChannelInFileTransactione < ActiveRecord::Migration
  def change
    rename_column :file_transactions, :method, :transaction_channel
  end
end
