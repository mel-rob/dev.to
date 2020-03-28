require "rails_helper"

RSpec.describe DailyDevMailer, type: :mailer do
  let(:user) { build_stubbed(:user) }
  let(:article) { build_stubbed(:article) }

  describe "#daily_dev_mailer" do
    before do
      allow(article).to receive(:title).and_return("test title")
    end

    it "sends an email" do
      email = described_class.daily_dev_email(user, [article])

      expect(email.subject).not_to be_nil
      expect(email.to).to eq([user.email])
      expect(email.from).to eq([SiteConfig.default_site_email])
      expect(email["from"].value).to eq("Daily Dev <#{SiteConfig.default_site_email}>")
    end
  end
end
