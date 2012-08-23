class AddTemplateToNewissuealerts < ActiveRecord::Migration
  def self.up
    add_column :newissuealerts, :template, :text
  end

  def self.down
    remove_column :newissuealerts, :template
  end
end
