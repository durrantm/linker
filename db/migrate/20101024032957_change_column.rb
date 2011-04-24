class ChangeColumn < ActiveRecord::Migration
  def self.up
	change_column :links, :group_id, :integer, :null => false
  end

  def self.down
	change_column :links, :group_id, :integer, :null => true
  end
end
