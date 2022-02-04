# https://www.rubydoc.info/github/jnunemaker/httparty/HTTParty/ClassMethods
require 'httparty'
require "openssl"
require "base64"

require_relative 'api_methods'
require_relative 'request'
require_relative 'signature'
require_relative 'skalp_helper'
require_relative 'websocket'
require_relative 'error_processing'
