require_relative 'user'
require_relative 'channel'


class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  def select(dataset: , id: nil, name: nil)
    match =  dataset.find do |user|
      user.id == id || user.name == name
    end

    raise ArgumentError.new ("Error: User not found.") if match == nil && dataset == users
    raise ArgumentError.new ("Error: Channel not found.") if match == nil && dataset  == channels

    return match
  end

end