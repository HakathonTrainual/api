# frozen_string_literal: true

class Api::V1::GamesController < ApplicationController
  include ChatGptRequest
  include Validatable

  def start_game
    @current_user
    random_users = Progress.where('percentage < 100').order("RANDOM()").limit(4).pluck(:user_id)
    users = User.where(id: random_users)
  end

  def end_game

  end

  private

  def generate_question
    api_key = ENV['OPENAI_API_KEY']
    keyword = params[:keyword]

    response = ChatGPTModule.generate_response("#{CONDITION_FOR_GPT} #{keyword}", api_key)

    question = response['choices'][0]['text']

    render json: { question: question }
  end
end
