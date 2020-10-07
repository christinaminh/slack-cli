require_relative "recipient"

USERS_URL = "https://slack.com/api/users.list"

class User < Recipient
  attr_reader :id, :name, :real_name

  def initialize(id:, name:, real_name: nil)
    super(id, name)

    @real_name = real_name
  end


  def self.list_all
    response = get(USERS_URL)

    users_list = response["members"].map do |user|
      User.new(id: user["id"], name: user["name"], real_name: user["real_name"])
    end

    return users_list
  end

  def details
    return "Slack ID: #{self.id}
    Name: #{self.name}"
  end

end