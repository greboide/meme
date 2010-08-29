module Meme

  class Request #:nodoc:

    def self.parse(query,oauth=nil)
      url = URI.escape("https://query.yahooapis.com/v1/public/yql?q=#{query}&format=json")
      if oauth
        urloauth = URI.escape("https://query.yahooapis.com/v1/yql?#{o.sign(url).query_string}")
        buffer = open(urloauth).read
      else
        buffer = open(url).read
      end
      if DEBUG_URI
        if oauth
          puts FakeWeb.registered_uri?(:get,urloauth).to_s
          puts urloauth;
        else
          puts FakeWeb.registered_uri?(:get,url).to_s
          puts url
        end
      end
      JSON.parse(buffer)
    end

  end

end
