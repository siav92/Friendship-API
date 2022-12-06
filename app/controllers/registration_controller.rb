class RegistrationController < ActionController::API
  def signup
    user = User.new(signup_params)

    if user.save
      render json: token_json(user), status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: login_params[:email])

    if user&.authenticate(login_params[:password])
      render json: token_json(user), status: :created
    else
      render json: { message: 'Wrong username or password provided!' }, status: :unauthorized
    end
  end

  private

  def signup_params
    params.require(:user).permit(:email, :password, :name)
  end

  def login_params
    params.require(:login).permit(:email, :password)
  end

  def token_json(user)
    { token: Registration::Token.generate_user_token(user) }
  end
end
