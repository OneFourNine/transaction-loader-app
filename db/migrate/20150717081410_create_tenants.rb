class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
    	t.string :name
    	t.string :user_key
    	t.datetime :remaining_time
    end
  end
end
