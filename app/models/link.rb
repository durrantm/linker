class Link < ActiveRecord::Base
  include HTTParty

  belongs_to :group
  validates_presence_of :url_address
  validates_presence_of :group_id
  validates_size_of :version_number, :maximum => 10 #, :allow_nil => true
  acts_as_list

  def valid_get?
    visit_url == 'ok'
  end

  def visit_url
    HTTParty.get(url_address).code.between?(200,399) ? 'ok' : 'not ok'
  rescue SocketError => error_detail
    return "not available"
  rescue NoMethodError => error_detail
    return "not valid"
  end

end
