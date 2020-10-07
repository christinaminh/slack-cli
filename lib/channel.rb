require_relative "recipient"

CONVERSATIONS_URL = "https://slack.com/api/conversations.list"

class Channel < Recipient
  attr_reader :id, :name, :topic, :member_count

  def initialize(id:, name:, topic: nil, member_count: nil)
    super(id, name)

    @topic = topic
    @member_count = member_count
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