module UsersHelper
  def sign_in(user)
    visit '/'
    
    find('.sign-in').fill_in 'user_email', :with => user.email
    find('.sign-in').fill_in 'user_password', :with => '12345678'

    click_button 'Sign in'
  end
end
