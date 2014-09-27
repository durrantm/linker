require 'spec_helper'

describe "Home Page", type: :feature do

  it "Visit the home page" do
    visit '/'
    expect(page).to have_content 'Linker'
    expect(page).to have_content 'Login'
    expect(page).to have_no_content 'Logout'
  end

end

describe "Show all the links", type: :feature do

  it "Shows me all links" do
    visit '/'
    click_link 'Links'
    expect(find('span#main')).to have_selector('table[data_links="true"]')
    expect(find('span#main table[data_links="true"] tr[data_header_row="true"]')).to have_content 'Group'
    expect(find('span[data_total]')).to have_content 'Total Links = 0'
    expect(find('span#main table tr[data_header_row="true"]')).to have_no_content 'Shading'
  end
end

describe "Shows all the groups", type: :feature do

  it "Shows me all groups" do
    visit '/'
    click_link 'Groups'
    expect(find('div#main h3')).to have_content 'Groups'
    expect(find('div#main h3')).to have_no_content 'Links'
  end
end

describe "Allows signin", type: :feature do

  before :each do
    User.create(username: 'rubdubdub@google.com', password: 'esceptionalitynessish')
  end

  it "signs me in" do
    visit '/ladmin/login'
    fill_in 'username', with: 'rubdubdub@google.com'
    fill_in 'password', with: 'esceptionalitynessish'
    find('input[value="Login"]').click
    expect(page).to have_content 'Logout'
    expect(page).to have_no_content 'Login'
  end
end
