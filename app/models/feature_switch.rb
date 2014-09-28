class FeatureSwitch < ActiveRecord::Base
  validates_presence_of :name, message: ' is required!'
  validates_presence_of :status, message: 'is required!'
  validates_uniqueness_of :name, message: 'must be unique!'
  STATUSES = ['on','on_if', 'off']
end
