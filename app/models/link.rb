class Link < ActiveRecord::Base
  belongs_to :group
  acts_as_list 
  validates_presence_of :url_address
  validates_presence_of :group_id
  validates_size_of :version_number, :maximum => 10
end
# :scope => :group
