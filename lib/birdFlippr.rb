class BirdFlipper
  require 'rubytter'
	require 'open-uri'
	require 'nokogiri'
	require 'highline'
	attr_accessor :client, :access_token

	def initialize

		key = "q6hTehLj2HS7nCnW4ne3Ag"
		secret = "nLQs87mwUUMMTGHQIMeAYr0H9QqAvG0lqCjuQVh8"

		@client = Rubytter::OAuth.new(key, secret)
		
		request_token = @client.get_request_token

		#doc = Nokogiri::HTML(open(request_token.authorize_url)) || puts("Access here: #{request_token.authorize_url}\nand...")
		#if ( doc.css('#loggedin').size == 1 )

		 #doc.css('#signin-content')


		system('open', request_token.authorize_url) || puts("Access here: #{request_token.authorize_url}\nand...")
    sleep 2
    ui = create_highline
    pin = ui.ask('Enter PIN: ')

		@access_token ||= request_token.get_access_token(
			:oauth_token => request_token.token,
			:oauth_verifier => pin
		)
		@client = OAuthRubytter.new(@access_token)
		
	end

	def get_tweets
    tweets = @client.home_timeline
  end


	def create_highline
		HighLine.track_eof = false
		if $stdin.respond_to?(:getbyte) # for ruby1.9
			def $stdin.getc; getbyte
			end
		end
		HighLine.new($stdin)
	end

end
