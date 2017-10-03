module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:id])
  end

  def login(user)
    session[:id] = user.id
  end

  def logged_in?
    !!current_user
  end

  def user_email(user)
    user.email
  end
end