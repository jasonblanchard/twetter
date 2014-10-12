class TwetNotification < ActionMailer::Base
  default from: "from@example.com"

  def new_twet_from_follower(poster, followers)
    @poster = poster
    recipients = followers.map(&:email)
    mail(:bcc => recipients, :subject => "#{@poster.name} sent a new twet!")
  end
end
