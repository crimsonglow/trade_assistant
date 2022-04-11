  # https://www.rubydoc.info/github/jnunemaker/httparty/HTTParty/ClassMethods
require 'httparty'
require 'openssl'
require 'base64'
require 'faye/websocket'
require 'eventmachine'
require 'awrence'
require 'byebug'

require_relative 'binance/api/api_methods'
require_relative 'binance/api/request'
require_relative 'binance/api/signature'
require_relative 'binance/strategies/skalp/skalp_helper'
require_relative 'binance/websocket'
require_relative 'binance/config_api'

module Binance

end
