class ChangeLinkContentDatetimeToDate < ActiveRecord::Migration
  def self.up
    change_column :links, :content_date, :date
  end

  def self.down
    change_column :links, :content_date, :datetime
  end
end
