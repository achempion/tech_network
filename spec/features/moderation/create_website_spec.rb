require 'rails_helper'

feature 'Add new website' do
  URL = "https://example.com"
  FEED_URL = "https://example.com/feed"
  FEED = {
    title: "Example Feed",
    updated_at: DateTime.parse("2003-12-13T18:30:02Z"),
    items: [
      {
        title: "Atom-Powered Robots Run Amok",
        link: "http://example.org/2003/12/13/atom03",
        updated_at: DateTime.parse("2003-12-13T18:30:02Z"),
        content: "Some text."
      }
    ]
  }


  scenario 'with valid data', js: true do
    expect(Feedbag).to receive(:find)
                         .twice
                         .with(URL)
                         .and_return([FEED_URL])

    expect(RssService).to receive(:call).with(FEED_URL).and_return(FEED)

    visit moderation_websites_path
    click_link "Add website"

    fill_in "Url", with: URL
    expect(page).to have_content(FEED_URL)

    choose FEED_URL

    expect(page).to have_field('Feed title', with: FEED[:title])

    expect(page).to have_content("Feed preview")
    expect(page).to have_content(FEED[:items][0][:title])
    expect(page).to have_content(FEED[:items][0][:content])

    click_button "Save"

    expect(page).to have_current_path(moderation_websites_path)
    expect(page).to have_content(FEED[:title])
  end
end
