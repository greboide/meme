require 'open-uri'
require 'json'

require 'meme/info'
require 'meme/search'
require 'meme/request'
require 'meme/user'

DEBUG_URI = nil
DEBUGGER = nil
OAUTH = nil

if DEBUGGER
  require 'ruby-debug-base' ; Debugger.start
end

# this is only required if you want to access private data and in this
# case you are encouraged to use the oauth mechanism from your app,
# the one included here is just so we can test it(at the very least
# you will need new api keys from yahoo for your app). In this case
# you will need to tweak the request mechanism.

if OAUTH
require 'external/oauth_util.rb'

o = OauthUtil.new
o.consumer_key = 'dj0yJmk9c2pjcUZSSFMzaDV3JmQ9WVdrOU5GUjJTSEIzTldVbWNHbzlNVGc0TnpFNU5qTTJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD1mMA--';
o.consumer_secret = '1c50819145aad6074d38aa35dae33f2fb1450126';

end
