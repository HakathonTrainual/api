class Api::V1::HobbiesController < ApplicationController
  before_action :find_user, only: :users_hobbies
  before_action :find_hobby, only: %i[show edit update destroy]

  def index
    @hobbies = Hobby.all
    render json: @hobbies
  end

  def users_hobbies
    @hobbies = @user.hobbies
    render json: @hobbies
  end

  def create
    @hobby = create_hobby(hobby_params[:name])
    assign_hobby_to_user(@user, @hobby)
  end

  def destroy
    @user.hobbies.delete(@hobby)
    head :no_content
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_hobby
    @hobby = Hobby.find(params[:id])
  end

  def hobby_params
    params.require(:hobby).permit(:name)
  end

  def create_hobby(name)
    Hobby.find_or_create_by(name: name)
  end

  def assign_hobby_to_user(user, hobby)
    user.hobbies << hobby
    user.save
    render json: hobby, status: :created
  end
end
