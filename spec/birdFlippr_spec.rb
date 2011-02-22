require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Birdflippr" do
	#This gets run once and only once in its own instance of Object
	before(:all) do
		@client = BirdFlipper.new(ENV['TWITTERCK'],ENV['TWITTERCS'])
	end
  it "should be able to get tweets" do
      @client.get_tweets.should_not be_empty
  end
	it "should be able to get the a questionable by its status id" do
		 tweet = @client.get_status(39807438735671297)
		 tweet.text.should match(/making an @dhh salad/)
	end
end
