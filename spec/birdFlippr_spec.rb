require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Birdflippr" do
  it "should be able to display tweets" do
    @client = BirdFlipper.new
    @client.get_tweets.should_not be_empty
  end
end
