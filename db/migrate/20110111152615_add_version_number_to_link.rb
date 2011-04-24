class AddVersionNumberToLink < ActiveRecord::Migration
  def self.up
    add_column :links, :version_number, :string
  end

  def self.down
    remove_column :links, :version_number
  end
end
