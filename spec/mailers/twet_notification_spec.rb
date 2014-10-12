require "spec_helper"

describe TwetNotification do

  describe "#new_tweet_from_follower" do

    let(:poster) { FactoryGirl.create(:user) }
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:user3) { FactoryGirl.create(:user) }

    it "sends an email to all the recipients" do
      email = TwetNotification.new_twet_from_follower(poster, [user1, user2, user3])
      email.deliver
      expect(ActionMailer::Base.deliveries.count).to eq 1
      expect(ActionMailer::Base.deliveries.last.bcc).to match_array [user1, user2, user3].map(&:email)
    end

    it 'has the right subject and body' do
      email = TwetNotification.new_twet_from_follower(poster, [user1, user2, user3])
      email.deliver
      email = ActionMailer::Base.deliveries.last

      expect(email.subject).to have_content "#{poster.name} sent a new twet!"

      expect(email.html_part.body).to have_content "New twet from #{poster.name}! Check it out at twetter"
      expect(email.text_part.body).to have_content "New twet from #{poster.name}! Check it out at twetter - "
    end
  end
end
