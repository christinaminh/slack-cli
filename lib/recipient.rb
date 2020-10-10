require 'dotenv'
require 'json'

# require_relative '../lib/bot_settings.json'
Dotenv.load

class SlackApiError < StandardError; end
class NoMessageError < StandardError; end

class Recipient
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  API_KEY = ENV["SLACK_API_TOKEN"]
  def self.get(url)
    response = HTTParty.get(url, query: { token: API_KEY })

    unless response.parsed_response["ok"]
      raise SlackApiError.new(response["error"])
    else
      return response
    end
  end

  CHAT_URL = "https://slack.com/api/chat.postMessage"
  BOT_API_KEY = ENV["SLACK_BOT_API_TOKEN"]
  def send_message(message)
    raise NoMessageError, "No message to send." if message.nil? || message.empty?

    settings_json = File.read("bot_settings.json")
    settings = JSON.parse(settings_json)

    response = HTTParty.post(CHAT_URL,
                             headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
                             body:{
                                 token: BOT_API_KEY,
                                 channel: self.id,
                                 text: message,
                                 icon_emoji: settings["icon_emoji"],
                                 username: settings["username"]
                             })

    raise SlackApiError, "Error occurred when sending #{message} to #{self.name}: #{response.parsed_response["error"]}" unless response.parsed_response["ok"]

    return true
  end

  def details
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end
end

