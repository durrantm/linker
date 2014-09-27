require 'spec_helper'

describe "verification", js: true, type: :feature do

  before :all do
    User.create(username: 'rubdubdub@google.com', password: 'esceptionalitynessish')
  end

  before :each do
    visit '/ladmin/login'
    fill_in 'username', with: 'rubdubdub@google.com'
    fill_in 'password', with: 'esceptionalitynessish'
    find('input[value="Login"]').click
  end

  it "lets me verify a link" do
    find('div#side div a', text: 'New Group').click
    fill_in 'group[group_name]', with: 'Group Add'
    click_button 'Save'
    find('div#side div a', text: 'New Link').click
    fill_in 'link[url_address]', with: 'http://www.a.com/newtest9876link'
    fill_in 'link[alt_text]', with: 'abcd9876'
    click_button 'Save'
    this_year=Time.now.strftime('%Y')
    l=Link.first
    l.update({verified_date: nil})
    expect(Link.count).to eq 1
    visit links_path
    find('a', text: "verify")
    click_link("verify", match: :first)
    sleep(3)
    expect(page).to have_content(this_year)
    click_link('Details')
    click_link('Delete')
    page.driver.browser.switch_to.alert.accept
    click_link('Groups')
    click_link('Delete')
    page.driver.browser.switch_to.alert.accept
  end

end

