require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Birdflippr" do
	#This gets run once and only once in its own instance of Object
	
	before(:all) do
		@client = BirdFlipper.new()
	end
	
  it "should be able to get tweets" do
      @client.get_tweets.should_not be_empty
  end
  
	it "should be able to get a tweet by its status id" do
		tweet = @client.get_status(39807438735671297)
		tweet.text.should match(/making an @dhh salad/)
	end
	
	it "should be able to get responses by a status id for a tweet that has a reply" do
	  responses = @client.get_responses(53901671767621634)
	  responses.size.should_not be_zero
	end
end
