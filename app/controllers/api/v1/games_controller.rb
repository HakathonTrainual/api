# frozen_string_literal: true

class GamesController < ApplicationController
  include ChatGPTModule
  include Validatable

  def start_game
    @current_user
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
