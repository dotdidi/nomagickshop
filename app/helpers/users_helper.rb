module UsersHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||=User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def set_user
    @user = User.find_by(params[:id])
  end
end
