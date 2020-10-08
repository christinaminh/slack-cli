require 'dotenv'
Dotenv.load

class SlackApiError < StandardError; end
class Recipient
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.get(url)
    response = HTTParty.get(url, query: { token: ENV["SLACK_API_TOKEN"] })

    if response["ok"] == false
      raise SlackApiError.new(response["error"])
    else
      return response
    end
  end

  def details
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end
end
