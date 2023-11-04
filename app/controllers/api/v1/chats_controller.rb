# frozen_string_literal: true

class ChatsController < ApplicationController
  include ChatGPTModule

  def generate_question
    api_key = ENV['OPENAI_API_KEY']
    keyword = params[:keyword]

    response = ChatGPTModule.generate_response("A few hobbies and a brief description are given.
You need to combine the hobby and the description to get a new description.
You don't need to separate the hobby and the description, you need to use the hobby in the description. Only one story: #{keyword}", api_key)

    question = response['choices'][0]['text']

    render json: { question: question }
  end
end
