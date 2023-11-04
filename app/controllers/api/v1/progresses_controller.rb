class Api::V1::ProgressesController < ApplicationController
  before_action :authorize_request
  before_action :set_user
  before_action :set_progress, only: [:show, :update, :destroy]

  def index
    @progresses = Progress.all
    render json: @progresses
  end

  def show
    render json: @progress, status: :ok
  end

  def create
    @progress = current_user.progresses.new(progress_params)

    if @progress.save
      render json: @progress, status: :created
    else
      render json: @progress.errors, status: :unprocessable_entity
    end
  end

  def update
    if @progress.update(progress_params)
      render json: @progress
    else
      render json: @progress.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @progress.destroy
    head :no_content
  end

  private

  def set_user
    current_user_id = current_user.id
    @user = User.find_by(id: current_user_id)
    user_id = @user.id
    @target_user = User.find_by(id: params[:target_user_id])
  end

  def set_progress
    @progress = Progress.find(params[:id])
  end

  def progress_params
    params.permit(
      :target_user_id, :percentage
    )
  end
end
