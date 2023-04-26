class Cleanup < ActiveRecord::Migration[7.0]
  def change
    drop_table :pair_requests
    drop_table :users
  end
end
