class Api::V1::AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by(email: login_params[:email])
    if @user&.authenticate(login_params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      # render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'), user_info: @user }, status: :ok
      render json: {
        token: token,
        exp: time.strftime('%m-%d-%Y %H:%M'),
        user_info: {
          user: @user.as_json(only: %i[id first_name last_name email]),
          hobbies: @user.hobbies.as_json(only: :name)
        }
      }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
