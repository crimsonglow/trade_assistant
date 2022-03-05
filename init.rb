require_relative 'binance'

# puts Binance::ApiMethods.futures_account_balance
# puts Binance::ApiMethods.change_initial_leverage(symbol: 'SANDUSDT', leverage: 11)

request = Binance::SkalpHelper.new(
  #coin_symbol: transfer to terminal before calling "COIN=SANDUSDT ruby init.rb"
  entry_price: float,
  quantity_coins: float,
  prise_close_trade: float,
  prise_without_loss: float,
  long_position: false,
  short_position: false
)

request.start_skalp_helper
