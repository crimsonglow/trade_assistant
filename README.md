The skript is designed to reduce the time spent on scalping.

You need to specify the API keys in the (config.rb) file.

Running the script through a file (init.rb).
Capabilities, mandatory parameters:
- (entry_price=) opens a position when coordinates are reached 
- (quantity_coins=) set the number of coins to buy 
- (prise_close_trade=) closes when the desired percentage is reached 
- (prise_without_loss=) allows to close a position at the place of opening if the price did not follow the scenario
- (long_position=true) & (short_position=true) depending on the desired entry into the trade.

- Data transfer and activation of the transaction is required to be transferred to the terminal sample:
coin_symbol=BTCUSDT entry_price=41500  quantity_coins=1.013  prise_close_trade=1.49 prise_without_loss=0.50  short_position=true ruby init.rb

- Leverage shift for trading, sample:
Binance::ApiMethods.change_initial_leverage(symbol: 'BTCUSDT', leverage: 11)
- You can check your balance through:
puts Binance::ApiMethods.futures_account_balance
- Check the connection of your api :
Binance::ApiMethods.ping



