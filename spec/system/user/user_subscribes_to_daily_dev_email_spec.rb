require "rails_helper"

RSpec.describe "Subscribes to Daily Dev Email", type: :system do
  let(:user) { create(:user, saw_onboarding: true) }

  before do
    sign_in(user)
    visit "/settings/notifications"
  end

  it "has option for user to subscribe to daily dev email" do
    expect(user.email_daily_dev).to be(false)

    expect(page).to have_unchecked_field("Send me an email that contains an article literally every day")
    page.check "Send me an email that contains an article literally every day"

    click_on "SUBMIT"
    user.reload

    expect(page).to have_text("Your profile was successfully updated.")
    expect(page).to have_checked_field("Send me an email that contains an article literally every day")

    expect(user.email_daily_dev).to be(true)
  end

  it "lets user change daily email setting" do
    expect(user.email_daily_dev).to be(false)
    page.check "Send me an email that contains an article literally every day"

    click_on "SUBMIT"
    user.reload

    expect(user.email_daily_dev).to be(true)

    page.uncheck "Send me an email that contains an article literally every day"

    click_on "SUBMIT"
    user.reload

    expect(user.email_daily_dev).to be(false)
  end
end
