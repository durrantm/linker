class ChangeColumnGroupName < ActiveRecord::Migration
  def self.up
	change_column :groups, :group_name, :string, :null => false
  end

  def self.down
	change_column :groups, :group_name, :string, :null => true
  end
end
