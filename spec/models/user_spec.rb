require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create(:user, username: 'user1', password: 'abc123', admin: true)}

  subject { user }
  it { should be_valid }
  it { should have_attribute :username }
  it { should respond_to :admin }
  it { should respond_to :password }

end

describe "keep admin" do

  its "Can't delete the only admin" do
    user1 = User.build(username: 'user1', password: 'abc123', admin: true)
    user.save!
    #user2 = User.create!(username: 'user2', password: 'def456', admin: true)
    #user3 = User.create!(username: 'user3', password: 'ghi798', admin: true)
    #User.delete_me(user1)
    #User.delete_me(user2)
    #User.delete_me(user3)
    expect(User.where(admin: true).count).to eq 3
  end

end
