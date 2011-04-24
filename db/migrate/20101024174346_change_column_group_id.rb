class ChangeColumnGroupId < ActiveRecord::Migration
  def self.up
	change_column :links, :group_id, :integer
  end

  def self.down
	change_column :links, :group_id, :integer
  end
end
