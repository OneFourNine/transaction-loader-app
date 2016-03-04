class CreateMambuInfos < ActiveRecord::Migration
  def change
    create_table :mambu_infos do |t|
      t.string :message
      t.references :file_transaction, index: true
    end
  end
end
