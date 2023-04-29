class ChangeDurationToIntInPairRequests < ActiveRecord::Migration[7.0]
  def change
    change_column :pair_requests, :duration, :integer
  end
end
