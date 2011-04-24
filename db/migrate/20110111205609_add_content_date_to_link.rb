class AddContentDateToLink < ActiveRecord::Migration
  def self.up
    add_column :links, :content_date, :datetime
  end

  def self.down
    remove_column :links, :content_date
  end
end
