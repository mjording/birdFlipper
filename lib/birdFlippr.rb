class BirdFlipper
  require 'rubytter'
	require 'open-uri'
	require 'nokogiri'
	require 'highline'
  require 'yaml'
	attr_accessor :client, :access_token

	def initialize()
    config_path = File.join(File.expand_path(File.dirname(__FILE__)),'..', 'config')
    config = YAML.load_file(File.join(config_path, 'config.yml'))
    
    access_token = get_access_token(config)
		@client = OAuthRubytter.new(access_token)
	end

	def get_tweets
    tweets = @client.home_timeline
  end
  
  def get_status(twitterid)
    status = @client.show(twitterid)
  end
  
  def get_responses(status_id)
    user_id = get_status(status_id)[:user][:id]
    params = { :user_id => user_id, :count => 200 }
    [].tap { |timeline|
      @client.user_timeline(user_id, params).each do |tweet|
        res = filter_tweet(tweet, status_id)

        timeline << res unless res.nil?
      end
    }#.uniq!
  end
  
  def filter_tweet(tweet, status_id)
    tweet if tweet[:in_reply_to_status_id_str] == status_id

    #[:text] #  
  end
  
  private
  
  def get_access_token(config)
    consumer = OAuth::Consumer.new(config[:twitter][:consumer_key], 
                  config[:twitter][:consumer_secret],
                  { :site => "http://api.twitter.com",
                    :scheme => :header})
    
    # now create the access token object from passed values
    token_hash = { :oauth_token => config[:twitter][:oauth_token],
                   :oauth_token_secret => config[:twitter][:oauth_token_secret]
                 }
                 
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
    
    return access_token
  end
end
