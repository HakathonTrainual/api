class Api::V1::UserHobbiesController < ApplicationController
  before_action :find_user
  before_action :find_user_hobby, only: %i[show edit update destroy]

  def index
    render json: current_user.hobbies
  end

  def show
    @user_hobbies = User.find(params[:id]).hobbies
    render json: @user_hobbies
  end

  def create
    @user_hobby = current_user.hobbies.new(hobby_params)
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

  def find_user_hobby
    @user_hobby = @user.hobbies.find(params[:id])
  end

  def hobby_params
    params.require(:hobby).permit(:name)
  end
end
