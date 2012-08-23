class AddSubjectToNewissuealerts < ActiveRecord::Migration
  def self.up
    add_column :newissuealerts, :subject, :string, :limit => 255
  end

  def self.down
    remove_column :newissuealerts, :subject
  end
end