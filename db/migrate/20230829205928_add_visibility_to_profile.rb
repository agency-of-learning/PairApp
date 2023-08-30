class AddVisibilityToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :visibility, :integer, default: 0, null: false
  end
end
