module Meme
  class User
    VARS = ["name","guid","followers","following","url","description","language", "avatar"]
    attr_accessor *VARS
    attr_accessor :posts

    def initialize(name) #:nodoc:
      data = Info.find(name)
      unless data.name.nil?
        VARS.each do |var|
          begin
            self.instance_variable_set("@#{var}", data.send(var))
          rescue
            warn "#{var} were not set properly."
            self.instance_variable_set("@#{var}", nil)
          end
        end
        self.posts = Meme::Post.posts(data.send(:guid))
      end
    end
  end
end
