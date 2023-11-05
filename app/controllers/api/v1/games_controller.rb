# frozen_string_literal: true

class Api::V1::GamesController < ApplicationController
  # include ChatGptRequest
  include Validatable

  def start_game
    all_users = User.all

    random_users = []
    all_users.each do |user|
      next if user == current_user
      progress = current_user.progresses.find_by(target_user_id: user.id)
      if progress.nil? || progress.percentage < 100
        random_users << user
      end
      break if random_users.length >= 4
    end

    random_users[0].status = true

    # result_string = "#{random_users[0].hobbies.join(', ')}: #{random_users[0].description}"
    result_string = 'спорт, охота, торти, я гарна людина'

    {
      question: generate_question(result_string),
      users: [current_user, random_users]
    }
  end

  def end_game
    result = params[answer]
    current_user.progresses.create(target_user_id: result) if result.present?
  end

  private

  def generate_question(string)
    ChatGptRequest.call(string)
  end
end
