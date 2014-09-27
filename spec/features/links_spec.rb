require 'spec_helper'

describe "Add and edit", type: :feature do

  before :all do
    User.create(username: 'rubdubdub@google.com', password: 'esceptionalitynessish')
  end

  before :each do
    visit '/ladmin/login'
    fill_in 'username', with: 'rubdubdub@google.com'
    fill_in 'password', with: 'esceptionalitynessish'
    find('input[value="Login"]').click
    find('div#side div a', text: 'New Group').click
    fill_in 'group[group_name]', with: 'Group Add'
    click_button 'Save'
  end

  it "lets me add a link" do
    find('div#side div a', text: 'New Link').click
    fill_in 'link[url_address]', with: 'http://www.railslinks.com/this_link_added'
    click_button 'Save'
    expect(page).to have_content('this_link_added')
  end

  it "lets me add a link, visit it in the index and then visit its details page" do
    find('div#side div a', text: 'New Link').click
    fill_in 'link[url_address]', with: 'http://www.a.com/newtest9876link'
    fill_in 'link[alt_text]', with: 'abcd9876'
    click_button 'Save'
    visit links_path
    find(:xpath, "//span[@id='main']//tr[4]//td//a[text()='Details']").click
    expect(page).to have_content('http://www.a.com/newtest9876link')
  end

  it "lets me add two links and see them in an index" do
    find('div#side div a', text: 'New Link').click
    fill_in 'link[url_address]', with: 'Link Add1'
    click_button 'Save'
    visit root_path
    find('div#side div a', text: 'New Link').click
    fill_in 'link[url_address]', with: 'Link Add2'
    click_button 'Save'
    visit links_path
    expect(page).to have_content('Link Add1')
    expect(page).to have_content('Link Add2')
  end

  it "lets me edit a link" do
    visit root_path
    find('div#side div a', text: 'New Link').click
    fill_in 'link[url_address]', with: 'Link Add'
    click_button 'Save'
    find('div#main a', text: "Edit").click
    fill_in 'link[url_address]', with: 'Link changed from show'
    click_button 'Save'
    expect(page).to have_content('Link changed')
    expect(page).to_not have_content('Link Add')
  end

  it "lets me delete a link" do
    find('div#side div a', text: 'New Link').click
    fill_in 'link[url_address]', with: 'Link to remove'
    click_button 'Save'
    find('div#main a', text: "Delete").click
    visit '/links'
    expect(page).to_not have_content('Link to remove')
  end

end
