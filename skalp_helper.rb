module Binance
  class SkalpHelper
    class << self
      attr_reader :coin_symbol, :position_types, :entry_price, :quantity_coins

      def coin_symbol=(coin_symbol)
        @coin_symbol = coin_symbol
      end

      def entry_price=(entry_price)
        @entry_price = entry_price
      end

      def position_types=(position_types)
        @position_types = position_types
      end

      def quantity_coins=(quantity_coins)
        @quantity_coins = quantity_coins
      end

      def open_trade_long
        Binance::ApiMethods.create_trade(symbol: coin_symbol, side: 'BUY', quantity: quantity_coins)
      end

      def close_trade_long
        Binance::ApiMethods.create_trade(symbol: coin_symbol, side: 'SELL', quantity: quantity_coins)
      end

      def open_trade_short
        Binance::ApiMethods.create_trade(symbol: coin_symbol, side: 'SELL', quantity: quantity_coins)
      end

      def close_trade_short
        Binance::ApiMethods.create_trade(symbol: coin_symbol, side: 'SELL', quantity: quantity_coins)
      end


      def prise_open_position_long
        open_prise = entry_price + entry_price * 0.10 / 100
      end

      def prise_take_position_long
        take_priese = entry_price + entry_price * 0.30 / 100
      end

      def prise_stop_position_long
        stop_prise = entry_price - entry_price * 0.30 / 100
      end

      def prise_open_position_short
        open_prise = entry_price - entry_price * 0.10 / 100
      end

      def prise_take_position_short
        take_priese = entry_price - entry_price * 0.30 / 100
      end

      def prise_stop_position_short
        stop_prise = entry_price + entry_price * 0.30 / 100
      end

    end
  end
end
