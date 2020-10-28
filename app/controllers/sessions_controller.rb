class SessionsController < Devise::SessionsController
  def create
    result = Zype::Auth.login(user_params[:email], user_params[:password])

    user = User.find_or_create_by(email: user_params[:email])
    user.update(user_params.merge!(result.except!('token_type', 'expires_in', 'created_at')))
    sign_in(user)

    redirect_to request.referrer, notice: 'Sign in successfully'
  rescue Zype::AuthenticationFailed => e
    flash.now[:error] = e.message
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
