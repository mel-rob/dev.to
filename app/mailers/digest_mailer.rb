# good mailer example to use for Daily Dev email
# we can use similar methods to run our mailer

class DigestMailer < ApplicationMailer
  default from: -> { "DEV Digest <#{SiteConfig.default_site_email}>" }

  # populates email with user and articles
  # creates subject and mailer action
  def digest_email(user, articles)
    @user = user
    @articles = articles.first(6)
    @unsubscribe = generate_unsubscribe_token(@user.id, :email_digest_periodic)
    subject = generate_title
    mail(to: @user.email, subject: subject)
  end

  private

  # this generates the article title, number, and emoji
  def generate_title
    "#{adjusted_title(@articles.first)} + #{@articles.size - 1} #{email_end_phrase} #{random_emoji}"
  end

  # formatting for article title
  def adjusted_title(article)
    title = article.title.strip
    "\"#{title}\"" unless title.start_with? '"'
  end

  # random emojis that are inserted in with title
  def random_emoji
    ["🤓", "🎉", "🙈", "🔥", "💬", "👋", "👏", "🐶", "🦁", "🐙", "🦄", "❤️", "😇"].shuffle.take(3).join
  end

  # adds end phrase to subject line - connected to 'generate_title' method
  def email_end_phrase
    # "more trending DEV posts" won the previous split test
    # Included more often as per explore-exploit algorithm
    [
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "more trending DEV posts",
      "other posts you might like",
      "other DEV posts you might like",
      "other trending DEV posts",
      "other top DEV posts",
      "more top DEV posts",
      "more top reads from the community",
      "more top DEV posts based on your interests",
      "more trending DEV posts picked for you",
    ].sample
  end
end
