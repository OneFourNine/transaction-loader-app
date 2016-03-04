class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string "excel_file"
      t.timestamps null: false
    end
  end
end
