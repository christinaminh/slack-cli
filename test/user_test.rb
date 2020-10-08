require_relative 'test_helper'

describe "User class" do
  before do
    @new_user = User.new(id: "USLACKBOT", name: "slackbot", real_name: "Bot")
  end

  describe "initialize" do
    it "returns instance of User" do
      expect(@new_user).must_be_instance_of User
    end

    it "must respond to name, real_name, and id" do
      expect(@new_user).must_respond_to :name
      expect(@new_user).must_respond_to :real_name
      expect(@new_user).must_respond_to :id
    end

    it "raises ArgumentError if id and name are not provided" do
      expect{
        User.new()
      }.must_raise ArgumentError
    end

    describe "list_all" do
      it "returns an array of User objects" do
        VCR.use_cassette("User.list_all") do
          users = User.list_all

          expect(users).must_be_kind_of Array

          users.each do |user|
            expect(user).must_be_instance_of User
          end

        end
      end
    end

    describe "details" do
      it "returns a string of user's id, username, and real name" do
      user_id = @new_user.id
      user_name = @new_user.name
      user_real_name = @new_user.real_name

      expect(@new_user.details).must_include user_id && user_name && user_real_name
      end
    end
  end
end