require 'open-uri'
require 'json'

require 'meme/info'
require 'meme/search'
require 'meme/request'

require 'oauth/consumer'

DEBUG_URI = nil
DEBUGGER = nil

if DEBUGGER
  require 'ruby-debug-base' ; Debugger.start
end
