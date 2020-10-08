describe "list_all" do
  VCR.use_cassette() do

    expect{}.must_raise SlackApiError
  end
end