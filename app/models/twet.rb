class Twet < ActiveRecord::Base
  belongs_to :user

  validates :content, :presence => true, :length => { :minimum => 2, :maximum => 140 }
  validates :user, :presence => true

  after_save :send_notification

  # Gets all twets made by the users referenced by the ids passed, starting with the
  # most recent twet made.
  #
  def self.by_user_ids(*ids)
    where(:user_id => ids.flatten.compact.uniq).order('created_at DESC')
  end

  private

  def send_notification
    @recipients = Follow.where(:following_id => self.user.id).map(&:user)
    TwetNotification.new_twet_from_follower(self.user, @recipients).deliver
  end
end
