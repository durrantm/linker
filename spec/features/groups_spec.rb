require 'spec_helper'

describe "Add and edit", :type => :feature do

  before :all do
    User.create(:username => 'rubdubdub@google.com', :password => 'esceptionalitynessish')
  end

  before :each do
    visit '/ladmin/login'
    fill_in 'username', :with => 'rubdubdub@google.com'
    fill_in 'password', :with => 'esceptionalitynessish'
    find('input[value="Login"]').click
    expect(page).to have_content 'Logout'
    expect(page).to have_no_content 'Login'
  end


  it "lets me add a group" do
    find('div#side div a', text: 'New Group').click
    fill_in 'group[group_name]', with: 'Group Add'
    click_button 'Save'
    expect(page).to have_content('Group Add')
  end

  it "lets me edit a group" do
    visit root_path
    find('div#side div a', text: 'New Group').click
    fill_in 'group[group_name]', with: 'Group EditABC'
    click_button 'Save'
    visit root_path
    find('div#side a', text: "Groups").click
    find(:xpath, "//td[text()='Group EditABC']/..//a[text()='Edit']").click
    fill_in 'group[group_name]', with: 'Group Edit changed'
    click_button 'Save'
    expect(page).to have_content('Group Edit changed')
  end

  it "lets me delete an empty group" do
    visit '/links'
    find('div#side a', text: 'New Group').click
    fill_in 'group[group_name]', with: 'Group DeleteDEF'
    click_button 'Save'
    find('div#side a', text: "Groups").click
    find(:xpath, "//td[text()='Group DeleteDEF']/..//a[text()='Delete empty group']").click
    visit '/groups'
    expect(page).to_not have_content('Group DeleteDEF')
  end
end
