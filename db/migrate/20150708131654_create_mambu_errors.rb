class CreateMambuErrors < ActiveRecord::Migration
  def change
    create_table :mambu_errors do |t|
      t.string :message
      t.string :code
      t.references :file_transaction, index: true
    end
  end
end
