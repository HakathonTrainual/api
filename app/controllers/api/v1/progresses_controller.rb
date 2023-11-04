class Api::V1::ProgressesController < ApplicationController
  before_action :set_user
  before_action :set_percentage, only: :show

  def index

  end

  def show
    render json: @percentage, status: :ok
  end

  def create
    progress = Progress.create(
      user: user,
      target_user: target_user,
      percentage: calculated_percentage
    )
  end

  private

  def set_user
    @user = User.find_by(id: current_user_id)
    @target_user = User.find_by(id: target_user_id)
  end

  def set_percentage
    @percentage =
  end
end
