class AddUuidToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :uuid, :uuid, default: 'uuid_generate_v4()'
  end
end
