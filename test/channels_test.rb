require_relative 'test_helper'

describe "Channel class" do
  before do
    @new_channel = Channel.new(id: "USLACKBOT", name: "slackbot", topic: "knock knock jokes", member_count: "40")
  end

  describe "initialize" do
    it "returns instance of Channel" do
      expect(@new_channel).must_be_instance_of Channel
    end

    it "must respond to id, name, topic, and member_count" do
      expect(@new_channel).must_respond_to :id
      expect(@new_channel).must_respond_to :name
      expect(@new_channel).must_respond_to :topic
      expect(@new_channel).must_respond_to :member_count
    end

    it "raises ArgumentError if id and name are not provided" do
      expect{
        Channel.new()
      }.must_raise ArgumentError
    end

    describe "list_all" do
      it "returns an array of Channel objects" do
        VCR.use_cassette("Channel.list_all") do
          channels = Channel.list_all

          expect(channels).must_be_kind_of Array

          channels.each do |channel|
            expect(channel).must_be_instance_of Channel
          end

        end
      end
    end

    describe "details" do
      it "returns a string of channel's id, name, topic, and member_count" do
        channel_id = @new_channel.id
        channel_name = @new_channel.name
        channel_topic = @new_channel.topic
        channel_member_count = @new_channel.member_count


        expect(@new_channel.details).must_include channel_id && channel_name && channel_topic && channel_member_count
      end
    end
  end
end