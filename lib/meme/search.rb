module Meme

  class Post

    VARS = ["category", "timestamp", "guid", "pubid", "url", "repost_count", "caption", "type", "content"] #:nodoc:

    attr_accessor *VARS

    def initialize(data) #:nodoc:
      unless data.nil?
        VARS.each do |var|
          self.instance_variable_set("@#{var}", data[var])
        end
      end
    end

    # Find posts
    #
    #   Example:
    #
    #   # type text
    #   posts = Meme::Post.find('brhackday')
    #
    #   # type photo
    #   posts = Meme::Post.find('brhackday', :type => :photo)
    #
    #   # type video
    #   posts = Meme::Post.find('brhackday', :type => :video)
    #
    #   posts.first.content
    #   => "RT @codepo8: And I am off - plane leaves BR for London. Thanks to everybody...
    #
    def self.find(query, options = {})
      type  = " and type='#{options.delete(:type).to_s}'" if options.has_key?(:type)
      query = "SELECT * FROM meme.search WHERE query='#{query}'#{type}"
      parse = Request.parse(query)
      if parse
        results = parse['query']['results']
        results.nil? ? nil : results['post'].map {|m| Post.new(m)}
      else
        parse.error!
      end
    end

    # Returns the top 10 posts on that moment.
    # You can also set the locale that you want to retrieve:
    #
    # * "en" for English
    # * "es" for Spanish
    # * "pt" for Portuguese (Default)
    # * "id" for Bahasa Indonesia
    #
    def self.popular(locale='pt')
      query = "SELECT * FROM meme.popular WHERE locale='#{locale}'"
      parse = Request.parse(query)
      if parse
        results = parse['query']['results']
        results.nil? ? nil : results['post'].map {|m| Post.new(m)}
      else
        parse.error!
      end
    end

    def user
      Meme::Info.find_by_guid(self.guid)
    end

    def self.posts(guid, pubid = nil)
      if pubid == nil
        query = "SELECT * FROM meme.posts WHERE owner_guid='#{guid}'"
      else
        query = "SELECT * FROM meme.posts WHERE owner_guid='#{guid}' AND pubid='#{pubid}'"
      end
      parse = Request.parse(query)
      if parse
        results = parse['query']['results']
        if results.nil?
          nil
        elsif (results['post'].class).to_s == "Hash"
          Post.new(results['post'])
        else
          results['post'].map {|m| Post.new(m)}
        end
      else
        parse.error!
      end
    end
  end

end
