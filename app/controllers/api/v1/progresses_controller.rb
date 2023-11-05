class Api::V1::UserHobbiesController < ApplicationController
  before_action :find_hobby, only: :destroy

  def index
    @user_hobbies = current_user.hobbies
    render_success(data: @user_hobbies, each_serializer: Api::V1::HobbySerializer)
  end

  def create
    @user_hobby = current_user.hobbies.new(hobby_params)
    if @user_hobby.save
      render_success(data: @user_hobby, serializer: Api::V1::HobbySerializer)
    else
      render_error(errors: @user_hobby.errors.full_messages)
    end
  end

  def destroy
    current_user.hobbies.delete(@user_hobby)
    render_success(data: 'Hobby deleted successfully')
  end

  private

  def hobby_params
    params.require(:hobby).permit(:name)
  end

  def find_hobby
    @hobby = current_user.hobbies.find(params[:id])
  end
end
