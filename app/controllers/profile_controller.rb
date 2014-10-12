class ProfileController < ApplicationController
  def show
    @user = User.find(params[:id])
    @twets = @user.twets.order('created_at DESC')
    @gravatar_hash = Digest::MD5.hexdigest(@user.email.downcase)
    @profile_img_src = "http://www.gravatar.com/avatar/#{@gravatar_hash}"
  end
  
end
