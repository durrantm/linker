require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create(:user, username: 'user1', password: 'abc123', admin: true)}

  subject { user }
  it { should be_valid }
  it { should have_attribute :username }
  it { should respond_to :admin }
  it { should respond_to :password }

end

describe "Make sure last admin cannot be deleted" do

  let!(:user1) { User.create(username: 'user100', password: 'abc123', admin: false) }

  it "how many" do
    user1.destroy rescue
    expect(User.all.count).to eq 1
  end

end

describe "Make sure last admin cannot be deleted" do

  let!(:user1) { User.create(username: 'user100', password: 'abc123', admin: true) }
  let!(:user2) { User.create(username: 'user200', password: 'abc123', admin: true) }

  it "how many" do
    User.delete_one_admin(user1)
    User.delete_one_admin(user2) rescue # expect error
    expect(User.where(admin: true).count).to eq 1
  end

end
