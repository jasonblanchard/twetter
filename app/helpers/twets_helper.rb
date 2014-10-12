module TwetsHelper
  
  def scrape_username(username)
    username.gsub('@','')
  end
  
  def body_with_mention(body)
    body.gsub(/(@\w+)/) do |mention|
      username = scrape_username(mention)
      user = User.find_by(:username => username)
      if user
        link_to mention, profile_path(user)
      else
        mention
      end
    end
  end
end
