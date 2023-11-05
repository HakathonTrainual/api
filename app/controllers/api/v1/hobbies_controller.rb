class Api::V1::HobbiesController < ApplicationController
  before_action :find_hobby, only: :destroy

  def index
    @hobbies = Hobby.all
    render_success(data: @hobbies, each_serializer: Api::V1::HobbySerializer)
  end

  def create
    @hobby = Hobby.new(hobby_params)
    if @hobby.save
      render_success(data: @hobby, serializer: Api::V1::HobbySerializer)
    else
      render_error(errors: @user.errors.full_messages)
    end
  end

  def destroy
    @hobby.destroy
    render_success(data: 'Hobby deleted successfully')
  end

  private

  def hobby_params
    params.require(:hobby).permit(:name)
  end

  def find_hobby
    @hobby = Hobby.find(params[:id])
  end
end
