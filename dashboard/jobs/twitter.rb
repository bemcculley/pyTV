require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = 'oJgFXZerxzI75UYXyjwSQ'
  config.consumer_secret = '0BbtEUhkNTsSrqrvUwIMMKztCPz1YHzkdzXzfcJOvo4'
  config.access_token = '2221894626-OgidG6ELN7Q4fCKD34SgGbvFZuKS7TmzZB1YMIj'
  config.access_token_secret = 'DvZgb7Nyg4Vwn9BGGOitUKMfnVTo7myGliGfeYLKEUg6v'
end

search_term = URI::encode('#denver')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = twitter.search("#{search_term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end
