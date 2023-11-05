class Api::V1::ProgressesController < ApplicationController
  before_action :set_user
  before_action :set_progress, only: [:show, :update, :destroy]

  def index
    @progresses = Progress.all
    render_success(data: @progresses, each_serializer: Api::V1::ProgressSerializer)
  end

  def show
    render_success(data: @progress, serializer: Api::V1::ProgressSerializer)
  end

  def create
    @progress = current_user.progresses.new(progress_params)

    if @progress.save
      @progress.percentage = 1
      render_success(data: @progress, serializer: Api::V1::ProgressSerializer)
    else
      render json: @progress.errors, status: :unprocessable_entity
    end
  end

  def update
    if @progress.increment(:percentage).save
      render_success(data: @progress, serializer: Api::V1::ProgressSerializer)
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
      :target_user_id
    )
  end
end
