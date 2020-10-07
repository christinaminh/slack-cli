

CONVERSATIONS_URL = "https://slack.com/api/conversations.list"


class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

end