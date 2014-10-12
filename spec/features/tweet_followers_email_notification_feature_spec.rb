require 'spec_helper'
include UsersHelper

feature 'Email notification when creating twets' do

  let(:poster) { FactoryGirl.create(:user) }
  let(:follower) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }

  before :each do
    ActionMailer::Base.deliveries = []
    follower.follows.create(:following => poster)
    sign_in poster
  end

  context 'when a user creates a twet' do

    before :each do
      visit '/'
      fill_in "twet_content", :with => "This is a new twet!"
      click_button "Twet"
    end

    it 'it sends an email notification to all followers' do
      expect(ActionMailer::Base.deliveries.length).to eq 1
      expect(ActionMailer::Base.deliveries.last.bcc).to include(follower.email)
    end

    it 'sends an email notification with the correct subject' do
      expect(ActionMailer::Base.deliveries.last.subject).to have_content "#{poster.name} sent a new twet!"
    end
  end
end
