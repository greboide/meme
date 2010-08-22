module Meme

  class Request #:nodoc:

    def self.parse(query)
      url = URI.escape("https://query.yahooapis.com/v1/public/yql?q=#{query}&format=json")
      if DEBUG_URI
        puts FakeWeb.registered_uri?(:get,url).to_s
        puts url
      end
      buffer = open(url).read
      JSON.parse(buffer)
    end

  end

end
