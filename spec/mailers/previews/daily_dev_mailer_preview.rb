# Preview all emails at http://localhost:3000/rails/mailers/
class DailyDevMailerPreview < ActionMailer::Preview
  def daily_dev_email
    DailyDevMailer.daily_dev_email(User.last, Article.limit(1).first)
  end
end
