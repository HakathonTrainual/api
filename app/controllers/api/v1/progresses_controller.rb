class Api::V1::ProgressesController < ApplicationController
  before_action :set_user

  def index

  end

  def show

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
    user = User.find_by(id: current_user_id)
    target_user = User.find_by(id: target_user_id)
  end
end
