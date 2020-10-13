require_relative 'user'
require_relative 'channel'


class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select(dataset: , id: nil, name: nil)
    @selected =  dataset.find do |recipient|
      recipient.id == id || recipient.name == name
    end

    raise ArgumentError.new ("User not found.") if @selected == nil && dataset == @users
    raise ArgumentError.new ("Channel not found.") if @selected == nil && dataset  == @channels

    return @selected
  end

  def show_details
    raise ArgumentError.new ("No user or channel selected.") unless @selected

    return @selected.details
  end

  def send_message(message)
    raise ArgumentError.new ("No user or channel selected.") unless @selected

    return @selected.send_message(message)
  end
end