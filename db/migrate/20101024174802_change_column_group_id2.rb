class ChangeColumnGroupId2 < ActiveRecord::Migration
  def self.up
	change_column :links, :group_id, :integer, {:null => true}
  end

  def self.down
	change_column :links, :group_id, :integer, {:null => false}
  end
end
