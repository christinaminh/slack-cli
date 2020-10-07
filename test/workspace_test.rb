require_relative 'test_helper'

describe "Workspace class" do
  before do
    @workspace = Workspace.new
  end

  describe "initialize" do
    it "creates an instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end

    it "has users and channels as attributes" do
      expect(@workspace).must_respond_to :users
      expect(@workspace).must_respond_to :channels
    end

    it " defaults users and channels as empty arrays" do
      expect(@workspace.users).must_equal Array.new()
      expect(@workspace.channels).must_equal Array.new()
    end

  end

  describe "get_channels" do
    it "returns an array of an array of strings" do
      VCR.use_cassette("get_channels") do
        response = @workspace.get_channels
        expect(response).must_be_kind_of Array


        # response.each do |channel|
        #   expect(channel[0..3]).must_be_kind_of String
        #   # expect(channel[1]).must_be_kind_of String
        #   # expect(channel[2]).must_be_kind_of String
        # end
      end
    end

    # it "returns correct number of channels" do
    #   VCR.use_cassette("get_channels") do
    #     response = get_channels
    #     expect(response.length).must_equal 47
    #   end
    # end

    # it "will raise an exception if the API call fails" do
    #   VCR.use_cassette("get_channels") do
    #
    #
    #     expect{get_channels}.must_raise SlackApiError
    #   end
    # end
  end
end