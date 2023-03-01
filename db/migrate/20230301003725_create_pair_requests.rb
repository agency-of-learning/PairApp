class CreatePairRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :pair_requests do |t|
      t.integer :author_id
      t.integer :acceptor_id
      t.datetime :when
      t.float :duration

      t.timestamps
    end
  end
end
