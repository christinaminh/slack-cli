require_relative "recipient"

CONVERSATIONS_URL = "https://slack.com/api/users.list"

class Channel < Recipient
  attr_reader :id, :name

  def initialize(id:, name: nil, topic: nil, member_count: nil)
    super(id, name)
  end


  def self.list_all
    response = get(CONVERSATIONS_URL)

    channels_list = response["channels"].map do |channel|
      Channel.new(
          id: channel["id"],
          name: channel["name"],
          topic: channel["topic"]["value"],
          member_count: channel["num_members"]
      )
    end

    return channels_list
  end
end