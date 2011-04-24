class Group < ActiveRecord::Base
  has_many :links, :dependent => :destroy 
  validates_presence_of :group_name
  validates_size_of :group_name, :maximum => 20
  default_scope :order => 'group_name'
end
