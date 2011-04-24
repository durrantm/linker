require 'test_helper'

class UserTest < ActiveSupport::TestCase

  fixtures :users

  def setup
    @user_1 = users(:first_new_user)
  end

  # Replace this with your real tests.
  test "Blank Record check" do
    record = User.new
    assert !record.valid?
  end
#
  test "Regular valid user" do
    @user_1.username = "test1"
    assert @user_1.valid?
  end

  test "Blank user" do
    @user_1.username = ""
    assert !(@user_1.valid?) # parens for clarity on !'s
  end

  test "Can access fixture" do
    assert(users(:first_new_user) != nil)
  end

  test "Regular fixture user" do
    @user_1.username = users(:first_new_user)
    assert @user_1.valid?
  end

  test "Blank username fixture user" do
    @user_2 = users(:blank_user)
    assert !(@user_2.valid?) # Not.
  end

end
