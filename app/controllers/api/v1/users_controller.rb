class Api::V1::UsersController < ApplicationController
  include TokenGenerationable

  skip_before_action :authorize_request, only: :create
  before_action :find_user, only: :show

  def index
    @users = User.all
    render_success(data: @users, each_serializer: Api::V1::UserSerializer)
  end

  def show
    render_success(data: @user, serializer: Api::V1::UserSerializer)
  end

  def show_current_user
    render_success(data: current_user, serializer: Api::V1::UserSerializer)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token_data = generate_token(@user.id)
      render_success(data: { token: token_data[:token],
                             expiration_date: token_data[:expiration_date],
                             user: @user }, status: :created)
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if current_user.update!(params.permit(:first_name, :last_name))
      render_success(data: current_user, serializer: Api::V1::UserSerializer)
    else
      render_error(errors: current_user.errors.full_messages)
    end
  end

  def destroy
    current_user.destroy
    render_success(data: 'User account deleted successfully')
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(
      :first_name, :last_name, :email, :password
    )
  end
end
