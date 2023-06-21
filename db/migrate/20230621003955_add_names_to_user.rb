class AddNamesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string, default: 'first_name', null: false
    add_column :users, :last_name, :string, default: 'last_name', null: false
  end
end
