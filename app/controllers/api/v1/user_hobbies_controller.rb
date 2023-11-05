class Api::V1::UserHobbiesController < ApplicationController
  before_action :find_user, only: :index
  before_action :user_id, only: %i[create destroy]
  before_action :find_user_hobby, only: :destroy #%i[show edit update destroy]

  def index
    render json: @user.hobbies
  end

  # def show
  #   @user_hobbies = User.find(params[:id]).hobbies
  #   render json: @user_hobbies
  # end

  def create
    @user_hobby = current_user.user_hobbies.new(user_hobby_params)

    if @user_hobby.save
      render json: @user_hobby, status: :created
    else
      render json: { errors: @user_hobby.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.hobbies.delete(@user_hobby)
    head :no_content
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def user_id
    current_user.id
  end

  def find_user_hobby
    @user_hobby = @user.hobbies.find(params[:id])
  end

  def user_hobby_params
    params.permit(:hobby_id)
  end
end
