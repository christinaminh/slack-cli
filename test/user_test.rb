require_relative 'test_helper'

describe "User class" do
  before do
    @new_user = User.new(id: "W012A3CDE")
  end

  describe "initialize" do
    it "returns instance of User" do

      expect(@new_user).must_be_instance_of User
    end

    it "must respond to username, name, and id" do
      expect(@new_user).must_respond_to :username
      expect(@new_user).must_respond_to :real_name
      expect(@new_user).must_respond_to :id
    end

    it "raises Argument error if id is nil" do
      expect{
        User.new()
      }.must_raise ArgumentError
    end


end