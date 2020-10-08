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
      expected_num_of_users = 162

      expect(num_of_users).must_equal expected_num_of_users
    end

    it "contains correct number of channel instances" do
      num_of_channels = @workspace.channels.length
      expected_num_of_channels = 48

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

  describe "show details" do
    it "returns details" do
      details = @workspace.show_details(@users[1])

      expect(details).must_be_kind_of String
      expect(details).must_include "U015QQ2BXFZ" && "jane" && "Jane Park"
    end

    it "will raise an ArgumentError if no class instance is passed" do
      expect{
        @workspace.show_details("String")
      }.must_raise ArgumentError
    end
  end

  # Cases where message is nil or user/channel doesn't exist has been tested in recipient_test.rb
  describe "send_message(instance, message)" do

    it "send a message to the correct user/channel" do
      VCR.use_cassette("Workspace_send_message") do
        test_channel2 = @workspace.select(dataset: @channels, id: "C01ABK51G14")
        channel_post_response = @workspace.send_message(test_channel2,"helloooo")

        expect(channel_post_response).must_equal true

        christina = @workspace.select(dataset: @users, name: "christina.minh")
        user_post_response = @workspace.send_message(christina, "helloooo")

        expect(user_post_response).must_equal true
      end
    end

    it "raises ArgumentError if instance isn't of User or Channel" do
      VCR.use_cassette("bad_recipient") do
        expect{
          @workspace.send_message("String", "Some message")
        }.must_raise ArgumentError
      end
    end
  end
end