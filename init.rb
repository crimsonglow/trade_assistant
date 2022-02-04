require_relative 'binance'

# start = Binance::SkalpHelper.new(
#                         coin_symbol: 'BNBUSDT',
#                         entry_price: 300,
#                         position_types: 'long'
#                         )

# start.indication_position

puts Binance::ApiMethods.new_trade_test
