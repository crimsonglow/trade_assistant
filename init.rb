require_relative 'binance'
# byebug
# puts Binance::ApiMethods.futures_account_balance
# puts Binance::ApiMethods.change_initial_leverage(symbol: 'BNBUSDT', leverage: 2)

Binance::SkalpHelper.coin_symbol = 'BNBUSDT'
Binance::SkalpHelper.entry_price = 367.5
Binance::SkalpHelper.quantity_coins = 0.04
Binance::SkalpHelper.position_types = 'short'  #'long','short'

# puts Binance::SkalpHelper.prise_stop_position_long

Binance::WebSocket.mark_prise_stream_request
