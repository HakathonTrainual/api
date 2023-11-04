# chat_gpt_module.rb
module ChatGPTModule
  require 'net/http'
  require 'json'

  BASE_URL = 'https://api.openai.com/v1/engines/davinci-codex/completions'.freeze

  def self.generate_response(prompt, api_key)
    uri = URI(BASE_URL)

    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{api_key}"
    }

    data = {
      'prompt' => prompt,
      'max_tokens' => 50
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, headers)
    request.body = data.to_json

    response = http.request(request)

    JSON.parse(response.body)
  end
end
