class Link < ActiveRecord::Base

  belongs_to :group
  validates_presence_of :url_address
  validates_presence_of :group_id
  validates_size_of :version_number, :maximum => 10 #, :allow_nil => true
  #before_save :verify_this_link # :verify_url, if: :url_address_changed?
  acts_as_list

  def valid_get?
    HTTParty.get(url_address).code.between?(100,399) ? true : false
  rescue SocketError, URI::InvalidURIError
    false
  end

  def verify_this_link
    verified_date = Time.now
  end

  def verified_date=(dt)
    verified_date=dt
  end

  private

  def verify_url
    if valid_get?
      verify_this_link
    end
  end

end
