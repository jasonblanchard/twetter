class TwetCreateService

  def initialize(twet, poster)
    @twet = twet
    @poster = poster
  end

  def execute
    @twet.save
    send_notification
    @twet
  end

  private

  def send_notification
    followers = Follow.where(:following_id => @poster.id).map(&:user)
    TwetNotification.new_twet_from_follower(@poster, followers).deliver
  end
end
