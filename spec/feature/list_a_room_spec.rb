require_relative "../spec_helper"

feature 'Rooms page' do
  scenario 'Rooms page says rooms' do
    visit('/rooms')
    expect(page).to have_content("Rooms")
  end
  scenario 'You can see a room' do
    visit('/rooms')
    expect(page).to have_content("Available")
  end
end
