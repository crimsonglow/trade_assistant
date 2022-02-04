# require_relative 'api_methods'
# require_relative 'websocket'

class SkalpHelper
  class << self
    attr_accessor :coin_symbol, :entry_price, :open_streams_prise

    def initialize(coin_symbol: nil, entry_price:, position_types:)
      @coin_symbol = coin_symbol
      @entry_price = entry_price
      @open_streams_prise = streams_prise
      @position_types = position_types
    end

    def indication_position
        open_streams_prise
      if position_types == 'long'
        if open_streams_prise >= entry_price
          new_trade_test
        end
      elsif position_types == 'short'
        if open_streams_prise <= entry_price
          new_trade_test
        end
      else position_types != 'long' || 'short'
        exit
      end
    end

    def prise_open_position_long
      entry_price += entry_price * 0.10 / 100
    end

    def prise_stop_position_long
      entry_price -= entry_price * 0.50 / 100
    end

    def prise_take_position_long
      entry_price += entry_price * 0.50 / 100
    end

    def prise_open_position_short
      entry_price -= entry_price * 0.10 / 100
    end

    def prise_stop_position_short
      entry_price += entry_price * 0.50 / 100
    end

    def prise_take_position_short
      entry_price -= entry_price * 0.50 / 100
    end
  end
end


