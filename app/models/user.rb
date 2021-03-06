class User < ActiveRecord::Base
  require 'digest/sha1'

  validates_presence_of     :username
  validates_uniqueness_of   :username
  validates_confirmation_of :password
  validate :password_non_blank

  def self.delete_one_admin(user)
    admin_count = User.where(admin: true).count
    if admin_count > 1
      user.delete
    else
      raise "You can't delete the only admin!"
    end
  end

  def self.authenticate(name, password)
    user = self.find_by(username: name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.pwd_hashed != expected_password
        user = nil
      end
    end
    user
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.pwd_hashed = User.encrypted_password(self.password, self.salt)
  end

  def is_admin
    admin ? 'Yes' : 'No'
  end

private
  def password_non_blank
    errors.add(:password, "Missing password") if pwd_hashed.blank?
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

end
