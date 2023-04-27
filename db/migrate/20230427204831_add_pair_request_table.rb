class AddPairRequestTable < ActiveRecord::Migration[7.0]
  def change
    create_table :pair_requests, force: :cascade do |t|
      t.integer "author_id", null: false, foreign_key: true
      t.integer "invitee_id", null: false, foreign_key: true
      t.datetime "when", null: false
      t.float "duration", null: false
      t.integer "status", default: 0, null: false

      t.timestamps null: false
    end
  end
end
