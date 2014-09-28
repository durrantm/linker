class CreateFeatureSwitches < ActiveRecord::Migration
  def change
    create_table :feature_switches do |t|
      t.text :status
      t.text :name
      t.text :description
      t.text :conditions

      t.timestamps
    end
  end
end
