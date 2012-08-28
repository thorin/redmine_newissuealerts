class AlterNewissuealertsSetDefaults < ActiveRecord::Migration
  def self.up
    change_column_default(:newissuealerts, :enabled, false)
  end

  def self.down
    change_column_default(:newissuealerts, :enabled, nil)
  end
end
