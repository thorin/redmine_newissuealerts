class AddPriorityToNewissuealerts < ActiveRecord::Migration
  def self.up
    add_column :newissuealerts, :priority, :boolean, :default => false
  end

  def self.down
    remove_column :newissuealerts, :priority
  end
end
