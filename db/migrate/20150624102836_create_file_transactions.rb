class CreateFileTransactions < ActiveRecord::Migration
  def change
    create_table :file_transactions do |t|
      t.string :account
      t.decimal :amount
      t.datetime :date
      t.string :reference
      t.string :type
      t.string :method
      t.string :identifier
      t.string :account_name
      t.string :receipt_name
      t.string :bank_number
      t.string :check_number
      t.string :bank_account_number
      t.string :bank_routing_number

      t.timestamps null: false
    end
  end
end
