class AddNamesToUser < ActiveRecord::Migration[7.0]
    def up
    add_column :users, :first_name, :string, null: true
    add_column :users, :last_name, :string, null: true

    User.update_all(first_name: 'first_name', last_name: 'last_name')

    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
  end

  def down
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
  end
end
