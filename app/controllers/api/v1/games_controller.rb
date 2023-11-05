# frozen_string_literal: true

class Api::V1::GamesController < ApplicationController
  include Validatable

  def start_game
    all_users = User.all

    random_users = []
    all_users.each do |user|
      next if user == current_user
      progress = current_user.progresses.find_by(target_user_id: user.id)
      debugger
      random_users << user if progress.nil? || progress.percentage < 100
      break if random_users.length >= 4
    end

    random_users[0].status = true

    result_string = "#{random_users[0].hobbies.join(', ')}: #{random_users[0].description}"

    res = {
      question: generate_question(result_string),
      users: random_users
    }
    render json: res, status: :ok
  end

  def end_game
    result = params[:id]
    if result.present?
      progress = current_user.progresses.create(target_user_id: result)
      progress.progresses += 1
    end
  end

  private

  def generate_question(string)
    ChatGptRequest.call("#{CONDITION_FOR_GPT + string}", 'gpt-3.5-turbo-0301')
  end
end
