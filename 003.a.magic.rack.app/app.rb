# We need a few superpowers for this example. Obviously,
require 'rack'
require 'pry'

# Ignore this line.
Signal.trap('INT') {Rack::Handler::WEBrick.shutdown}

# Now let's grab the superpower twitter.

# https://github.com/sferik/twitter

# First, install the twitter gem from your terminal.

# gem install twitter

# Great, let's get it in this script.

require 'twitter'

TWITTER = Twitter::REST::Client.new do |config|
  # I got this information from creating a new twitter application
  # under my developer account. 
  # https://dev.twitter.com/apps
  config.consumer_key = "YThFpw0CyXIJ8g73AAmCHUJL5"
  config.consumer_secret = "KIkenjO7wv248jSNIKltOSZIjWXiORQEpSNVRxgO5MsO7Ht3wq"
  config.access_token = "276237692-vwCB7oLa5TWBoDFv7MVdap6aDxzAqdVFbpyjrwQM"
  config.access_token_secret = "iXQ7vSO7Rvq8zVnZO3u8LDRMQvTzcHCfTRDUTBB3ZNRk0"
end

# What do you think is going on up there? Well the twitter gem gives us a class,
# Twitter. We're configure the class with our credentials. Now that class basically
# represents twitter.

# Let's make our rack app.

class App
  def call(env)
    html = "<h1>What people are saying about Flatiron School</h1>"
    html << "<ul>"

    # So far we've created an HTML string. Now the fun part. 
    # Let's search twitter.
    twitter_search_results = TWITTER.search("flatironschool")
    twitter_search_results.each do |tweet|
      # So now we have these individual tweet objects, twitter statuses.
      html << "<li>#{tweet.user.name} says: #{tweet.text}</li>"
    end
    html << "</ul>"

    [200, {'Content-Type' => 'text/html'}, [html]]
  end
end

# Okay and now our Rack Handler to actually load the application
# on port 3002 of our computer.

Rack::Handler::WEBrick.run(App.new, {:Port => 3002})

# You should see the Rack output letting you know you have a server
# running, this time on port 3002.

# Open your browser again to http://localhost:3002
#
# Now look and see what people are saying about the Flatiron School on Twitter!
#
# What else can you build into this? Check out the Twitter gem
# here https://github.com/sferik/twitter
#
# See what else you can do with rack!
