require 'dotenv'
Dotenv.load

class Recipient
  attr_reader :id, :name

  def initialize(id:, name: nil)
    @id = id
    @name = name
  end

  def self.get(url)
    response = HTTParty.get(url, query: { token: ENV["SLACK_API_TOKEN"] })

    return response
  end



end