class Link < ActiveRecord::Base

  belongs_to :group
  validates_presence_of :url_address
  validates_presence_of :group_id
  validates_size_of :version_number, :maximum => 10 #, :allow_nil => true
  validates_uniqueness_of :url_address, scope: :group_id, message: 'already exists in that group'
  validate :url_address_not_just_http
  before_save :verify_url, if: :url_address_changed?
  acts_as_list

  def valid_get?
    HTTParty.get(url_address).code.between?(100,399) ? true : false
  rescue SocketError, URI::InvalidURIError
    false
  end

  def verify_url
    if valid_get?
      self.verified_date = Time.now
    end
  end

  def alt_text_or_url
    if alt_text == ''
      alt_text_or_url_address = url_address
    else
      alt_text_or_url_address = alt_text
    end
  end
end

def url_address_not_just_http
  errors.add(:url_address, "can't be just http://") if url_address == 'http://'
end
