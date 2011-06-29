class Link < ActiveRecord::Base
  belongs_to :group
  validates_presence_of :url_address
  validates_presence_of :group_id
  validates_size_of :version_number, :maximum => 10
  acts_as_list

#  named_scope :searcher, :conditions => ["url_address like ? or alt_text_like ? or version_number like ? ", search_string, search_string, search_string]
# Not working yet mdd 5/2/2011
=begin
  named_scope :searcher, lambda { |search_string|
  { :conditions => ["url_address like ? or alt_text_like ? or version_number like ? ", search_string, search_string, search_string]}
  }
=end
#  end

end
# :scope => :group
