class Api::V1::HobbiesController < ApplicationController
  before_action :find_hobby, only: :destroy

  def index
    @hobbies = Hobby.all
    render json: @hobbies
  end

  def create
    @hobby = Hobby.new(hobby_params)
    if @hobby.save
      render json: @hobby, status: :created
    else
      render json: { errors: @hobby.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @hobby.destroy
    head :no_content
  end

  private

  def hobby_params
    params.require(:hobby).permit(:name)
  end

  def find_hobby
    @hobby = Hobby.find(params[:id])
  end
end
