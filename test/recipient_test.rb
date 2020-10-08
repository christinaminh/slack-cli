require_relative 'test_helper'

describe "Recipient class" do
  before do
    @recipient = Recipient.new("some_id", "some_name")
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