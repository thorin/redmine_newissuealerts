class AddTrackerToNewissuealerts < ActiveRecord::Migration
  def self.up
    add_column :newissuealerts, :tracker_id, :integer
  end

  def self.down
    remove_column :newissuealerts, :tracker_id
  end
end