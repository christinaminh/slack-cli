require_relative 'test_helper'

describe "Recipient class" do
  before do
    @recipient = Recipient.new(id: "W012A3CDE")
  end

  describe "initialize" do
    it "returns instance of User" do

      expect(@recipient).must_be_instance_of Recipient
    end

    it "must respond to username, name, and id" do
      expect(@recipient).must_respond_to :id
    end

    it "raises Argument error if id is nil" do
      expect{
        Recipient.new()
      }.must_raise ArgumentError
    end


  end