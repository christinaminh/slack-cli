require_relative 'test_helper'

describe "Workspace class" do
  before do
    VCR.use_cassette("load users and channels") do
      @workspace = Workspace.new
      @channels = @workspace.channels
      @users = @workspace.users
    end
  end

  describe "initialize" do
    it "creates an instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end

    it "has users and channels as attributes" do
      expect(@workspace).must_respond_to :users
      expect(@workspace).must_respond_to :channels
    end

    it "contains users which is an array of user instances" do
      @workspace.users.each do |user|
        expect(user).must_be_kind_of User
      end
    end

    it "contains channels which is an array of channel instances" do
      @workspace.channels.each do |channel|
        expect(channel).must_be_kind_of Channel
      end
    end

    it "contains correct number of users instances" do
      num_of_users = @workspace.users.length
      expected_num_of_users = 158

      expect(num_of_users).must_equal expected_num_of_users
    end

    it "contains correct number of channel instances" do
      num_of_channels = @workspace.channels.length
      expected_num_of_channels = 47

      expect(num_of_channels).must_equal expected_num_of_channels
    end
  end

  describe "select" do
    it "returns an instance of User if given user id or name" do
      user_with_id = @workspace.select(dataset: @users, id: "U015QQ2BXFZ")
      user_with_name = @workspace.select(dataset: @users, name: "slackbot")

      expect(user_with_id).must_be_kind_of User
      expect(user_with_name).must_be_kind_of User
    end

    it "returns an instance of Channel if given channel id or name" do
      channel_with_id = @workspace.select(dataset: @channels, id: "C0165N9BX3M")
      channel_with_name = @workspace.select(dataset: @channels, name: "fur-babes")

      expect(channel_with_id).must_be_kind_of Channel
      expect(channel_with_name).must_be_kind_of Channel
    end

    it "raise an ArgumentError if user doesn't exist with provided id or name" do
      expect{
        @workspace.select(dataset: @users, id: "nonsense_id")
      }.must_raise ArgumentError

      expect{
        @workspace.select(dataset: @users, name: "nonsense_name")
      }.must_raise ArgumentError
    end

    it "raise an ArgumentError if channel doesn't exist with provided id or name" do
      expect{
        @workspace.select(dataset: @channels, id: "nonsense_id")
      }.must_raise ArgumentError

      expect{
        @workspace.select(dataset: @channels, name: "nonsense_name")
      }.must_raise ArgumentError
    end
  end
end