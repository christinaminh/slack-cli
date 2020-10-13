require_relative 'test_helper'

describe "Recipient class" do
  before do
    VCR.use_cassette("load workspace") do
      @workspace = Workspace.new
      @channels = @workspace.channels
      @users = @workspace.users
      @recipient = Recipient.new("some_id", "some_name")
    end
  end

  describe "initialize" do
    it "returns instance of Recipient" do
      expect(@recipient).must_be_instance_of Recipient
    end

    it "must respond to id and name" do
      expect(@recipient).must_respond_to :id
      expect(@recipient).must_respond_to :name
    end
  end

  describe "get(url)" do
    it "will raise an ArgumentError if no url provided" do
      VCR.use_cassette("get recipient") do
        expect{
        Recipient.get()
        }.must_raise ArgumentError
      end
    end
  end

  describe "send_message(message)" do
    it "can send a message to recipient" do
      VCR.use_cassette("send_message") do
        test_channel2 = @workspace.select(dataset: @channels, id: "C01ABK51G14")
        post_response = test_channel2.send_message("helloooo")

        expect(post_response).must_equal true

        christina = @workspace.select(dataset: @users, name: "christina.minh")
        post_response = christina.send_message("helloooo")

        expect(post_response).must_equal true
      end
    end

    it "raises a NoMessageError if message is an empty string" do
      VCR.use_cassette("empty string") do
        @workspace.select(dataset: @users, name: "christina.minh")

        expect{
          @recipient.send_message("")
        }.must_raise NoMessageError
      end
    end

    it "raises a NoMessageError if message is nil" do
      @workspace.select(dataset: @users, name: "christina.minh")

      VCR.use_cassette("no message") do
        expect{
          @workspace.send_message(nil)
        }.must_raise NoMessageError
      end
    end

    it "raises an ArgumentError if no user/channel selected" do

      VCR.use_cassette("no user or channel selected") do
        expect{
          @workspace.send_message("message to no one")
        }.must_raise ArgumentError
      end
    end
  end

  describe "details" do
    it "raises an error if invoked directly (without subclassing)" do
      expect {
        @recipient.details
      }.must_raise NotImplementedError
    end
  end

  describe "self.list_all" do
    it "raises an error if invoked directly (without subclassing)" do
      expect {
        Recipient.list_all
      }.must_raise NotImplementedError
    end
  end
end