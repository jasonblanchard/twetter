class ProfileController < ApplicationController
  def show
    @user = User.find(params[:id])
    @twets = @user.twets.order('created_at DESC')
  end
  
end
