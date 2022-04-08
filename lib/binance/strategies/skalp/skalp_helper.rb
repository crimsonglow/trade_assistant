module Binance
 class SkalpHelper
    attr_reader :coin_symbol, :entry_price, :quantity_coins, :percent__breakeven, :percent_close_trade, :leverage_for_coin, :long_position, :short_position, :allow_trade, :allow_to_close_breakeven

    def initialize(transaction_details: {})
      @coin_symbol = transaction_details["coin_symbol"]
      @entry_price = transaction_details["entry_price"].to_f
      @quantity_coins = transaction_details["quantity_coins"].to_f
      @percent_close_trade = transaction_details["percent_close_trade"].to_f
      @percent__breakeven = transaction_details["percent__breakeven"].to_f
      @leverage_for_coin = transaction_details["leverage_for_coin"].to_i
      @long_position = true if transaction_details["long_position"] == 'true'
      @short_position = true if transaction_details["short_position"] == 'true'
      @allow_trade = false
      @allow_to_close_breakeven = false
    end

    def start_skalp_helper
      Binance::ApiMethods.change_initial_leverage(symbol: coin_symbol, leverage: leverage_for_coin)
      Binance::WebSocket.stream_request(stream__behavior: stream_price_behavior, coin_symbol: coin_symbol)
    end

protected

    def stream_price_behavior
      proc do |e|
        data = JSON.parse(e.data, symbolize_names: true)
        stream_price = data.dig(:k, :c).to_f

        if long_position
          try_to_open_position_long(stream_price: stream_price)
          next unless allow_trade
          try_to_close_via_take_profit_long(stream_price: stream_price)
          try_to_close_via_stop_price_long(stream_price: stream_price)
          try_to_close_in_breakeven_long(stream_price: stream_price)
        end

        if short_position
          try_to_open_position_short(stream_price: stream_price)
          next unless allow_trade
          try_to_close_via_take_profit_short(stream_price: stream_price)
          try_to_close_via_stop_price_short(stream_price: stream_price)
          try_to_close_in_breakeven_short(stream_price: stream_price)
        end
      end
    end


private
  # logic of the structure for opening and closing positions
    def open_trade
      if long_position
        Binance::ApiMethods.create_trade(symbol: coin_symbol, side: 'BUY', quantity: quantity_coins)
      elsif short_position
       Binance::ApiMethods.create_trade(symbol: coin_symbol, side: 'SELL', quantity: quantity_coins)
      end
      puts action_time
    end

    def close_trade
      if long_position
        Binance::ApiMethods.create_trade(symbol: coin_symbol, side: 'SELL', quantity: quantity_coins)
      elsif short_position
       Binance::ApiMethods.create_trade(symbol: coin_symbol, side: 'BUY', quantity: quantity_coins)
      end
      puts action_time
    end
  # logic for build price for coordination of actions
    def prise_to_open_position
      if long_position
        prise_to_open_position = entry_price + entry_price * 0.10 / 100
      elsif short_position
        prise_to_open_position = entry_price - entry_price * 0.10 / 100
      end
    end

    def take_profit
      if long_position
        prise_take_profit = entry_price + entry_price * percent_close_trade / 100
      elsif short_position
        prise_take_profit = entry_price - entry_price * percent_close_trade / 100
      end
    end

    def stop_lose
      if long_position
       prise_stop_lose = entry_price - entry_price * percent_close_trade / 100
      elsif short_position
       prise_stop_lose = entry_price + entry_price * percent_close_trade / 100
      end
    end

    def way_to_breakeven
      if long_position
       prise_way_to_breakeven = entry_price + entry_price * percent__breakeven / 100
      elsif short_position
       prise_way_to_breakeven = entry_price - entry_price * percent__breakeven / 100
      end
    end

    def stop_lose_breakeven
      if long_position
       prise_stop_position_breakeven = entry_price + entry_price * 0.06 / 100
      elsif short_position
       prise_stop_position_breakeven = entry_price - entry_price * 0.06 / 100
      end
    end
  # time at the moment of activation
    def action_time
      Time.new
    end
  # logic to control actions when the stream price reaches the specified conditions
    def try_to_open_position_long(stream_price:)
      if stream_price > entry_price && allow_trade == false
        puts "Open position to long. Prce: #{stream_price}"
        open_trade
        sleep(10)
        @allow_trade = true
      end
    end

    def try_to_close_via_take_profit_long(stream_price:)
      if stream_price > take_profit
        puts "Closed position in profit. Prce: #{stream_price}"
        close_trade
        exit
      end
    end

    def try_to_close_via_stop_price_long(stream_price:)
      if stream_price < stop_lose
        puts "Closed position to stop. Prce: #{stream_price}"
        close_trade
        exit
      end
    end

    def try_to_close_in_breakeven_long(stream_price:)
      @allow_to_close_breakeven = true if stream_price > way_to_breakeven
      if stream_price < stop_lose_breakeven && allow_to_close_breakeven == true
        puts "Closed position in without loss. Prce: #{stream_price}"
        close_trade
        exit
      end
    end

    def try_to_open_position_short(stream_price:)
      if stream_price < entry_price && allow_trade == false
        puts "Open position to short. Prce: #{stream_price}"
        open_trade
        sleep(10)
        @allow_trade = true
      end
    end

    def try_to_close_via_take_profit_short(stream_price:)
      if stream_price < take_profit
        puts "Closed position in profit. Prce: #{stream_price}"
        close_trade
        exit
      end
    end

    def try_to_close_via_stop_price_short(stream_price:)
      if stream_price > stop_lose
        puts "Closed position to stop. Prce: #{stream_price}"
        close_trade
        exit
      end
    end

    def try_to_close_in_breakeven_short(stream_price:)
      @allow_to_close_breakeven = true if stream_price < way_to_breakeven
      if stream_price > stop_lose_breakeven && allow_to_close_breakeven == true
        puts "Closed position in without loss. Prce: #{stream_price}"
       close_trade
        exit
      end
    end

  end
end
