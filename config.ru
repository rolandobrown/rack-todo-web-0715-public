require 'rack'
require 'pry'
Signal.trap('INT') {Rack::Handler::WEBrick.shutdown}

require 'twitter'

TWITTER = Twitter::REST::Client.new do |config|
  config.consumer_key = "00tfQ0A7HlWvADGrYEExBk2Rb"
  config.consumer_secret = "QK0X8bMkOnAG9p7iVYYVS4hucYWF7vmUsTngMflqiKHQG2UEUd"
  config.access_token = "11042-ZVDQyo9NGF60rIB1XHC25ppksMku3vHgLqiqz6JHIZVW"
  config.access_token_secret = "xh3v09YexAUjvJVOjNSU3tsMAVk7T8yjc36DQL2VRS4pi"
end

class App
  def call(env)
    html = "<h1>What people are saying about Flatiron School</h1>"
    html << "<ul>"
    twitter_search_results = TWITTER.search("flatironschool")
    twitter_search_results.each do |tweet|
      html << "<li>#{tweet.user.name} says: #{tweet.text}</li>"
    end
    html << "</ul>"

    [200, {'Content-Type' => 'text/html'}, [html]]
  end
end
Rack::Handler::WEBrick.run(App.new, {:Port => 3002})
