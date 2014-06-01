class AddVerifiedDateToLinks < ActiveRecord::Migration
  def change
    add_column :links, :verified_date, :datetime
  end
end
