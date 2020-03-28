class DailyDevMailer < ApplicationMailer
  default from: -> { "Daily Dev <#{SiteConfig.default_site_email}>" }

  def daily_dev_email(user, article)
    track extra: { article_id: article.id }
    @user = user
    @article = article
    @unsubscribe = generate_unsubscribe_token(@user.id, :email_daily_dev)
    subject = "Your Daily Dev"
    mail(to: @user.email, subject: subject)
  end
end
