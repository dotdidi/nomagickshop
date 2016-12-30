module UsersHelper
  def set_user
    @user = User.find_by(params[:id])
  end
end
