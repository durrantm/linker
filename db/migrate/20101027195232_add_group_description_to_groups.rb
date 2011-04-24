class AddGroupDescriptionToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :group_description, :string
  end

  def self.down
    remove_column :groups, :group_description
  end
end
