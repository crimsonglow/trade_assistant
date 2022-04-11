The skript is designed to reduce the time spent on scalping.

You need to specify the API keys in the (config.rb) file.

Running the script through a file (init.rb).
Capabilities, mandatory parameters:
- (coin_symbol=) coin quote;
- (entry_price=) opens a position when coordinates are reached ;
- (quantity_coins=) set the number of coins to buy;
- (percent_close_trade=) closes when the desired percentage is reached;
- (percent__breakeven=) allows to close a position at the place of opening if the price did not follow the scenario;
- (long_position=true) & (short_position=true) depending on the desired entry into the trade;
- (leverage_for_coin=) leverage shift for trading.

- Data transfer and activation of the transaction is required to be transferred to the terminal sample:
coin_symbol=BTCUSDT entry_price=41500  quantity_coins=1.013  percent_close_trade=1.49 percent__breakeven=0.50 short_position=true leverage_for_coin=11 ruby init.rb

- You can check your balance through:
puts Binance::ApiMethods.futures_account_balance
- Check the connection of your api:
Binance::ApiMethods.ping


Scheduled:
- Receiving data for a trade through a telegram bot;
- Data transfer within the system using the database.



