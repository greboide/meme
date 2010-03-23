class Meme

  class Info

    def initialize(name)
      url     = URI.escape("https://query.yahooapis.com/v1/public/yql?q=SELECT * FROM meme.info WHERE name='#{name}'&format=json")
      buffer  = open(url).read
      @owner  = JSON.parse(buffer)
      self.class.define = @owner
    end

    def self.find(name)
      Info.new(name)
    end

    private

    def self.define=(owner)
      raise 'Meme user not found' if owner['query']['results'].nil?
      owner['query']['results']['meme'].each do |key, value|
        define_method(key) { value }
      end
    end

  end

  class Post

    VARS = ["category", "timestamp", "guid", "pubid", "url", "repost_count", "caption", "type", "content"]

    attr_accessor *VARS

    def initialize(data)
      unless data.nil?
        VARS.each do |var|
          self.instance_variable_set("@#{var}", data[var])
        end
      end      
    end

    def self.find(query, options = {})
      type = " and type='#{options.delete(:type).to_s}'" if options.has_key?(:type)
      url = URI.escape("https://query.yahooapis.com/v1/public/yql?q=SELECT * FROM meme.search WHERE query='#{query}'#{type}&format=json")
      buffer = open(url).read
      parse = JSON.parse(buffer)['query']['results']['post']
      if parse
        return parse.map {|m| Post.new(m)}
      else
        parse.error!
      end
    end

  end

end
