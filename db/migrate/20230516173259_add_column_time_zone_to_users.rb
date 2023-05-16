class AddColumnTimeZoneToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :time_zone, :string, default: 'UTC', null: false
  end
  def up
    add_column :users, :time_zone, :string, default: 'UTC'
    User.update_all(time_zone: 'UTC')
    change_column :users, :time_zone, :string, null: false
   end
   
   def down
    remove_column :users, :time_zone
   end
  def change
    add_column :users, :time_zone, :string, default: 'UTC', null: false
  end
end
