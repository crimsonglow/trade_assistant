require_relative 'signature'
require_relative 'request'

module ApiMethods
  include Builder

  # https://binance-docs.github.io/apidocs/futures/en/#market-data-endpoints
  def ping

  end

  # https://binance-docs.github.io/apidocs/futures/en/#check-server-time
  def check_server_time
    Request.send(path: "/api/v1/time")
  end

  # https://binance-docs.github.io/apidocs/futures/en/#exchange-information
  def exchange_information

  end

  # https://binance-docs.github.io/apidocs/futures/en/#symbol-price-ticker
  def check_price

  end

  # https://binance-docs.github.io/apidocs/futures/en/#new-order-trade
  def new_trade(symbol:, side:, type: 'LIMIT_MAKER', quantity:, price:)
    timestamp
    parameters{
      symbol: symbol,
      side: side,
      type: type,
      quantity:  quantity,
      price: price,
      timeInForce: 'IOC',
      newOrderRespType: 'FULL'}
      Request.send(path: "/api/v1/trades", parameters: parameters)
  end

    def new_trade_test
    timestamp
    parameters{
      symbol:'BNBUSDT',
      side: 'BUY',
      type: 'MARKET',
      quantity: 0.039,
      price: nil,
      timeInForce: 'IOC',
      newOrderRespType: 'FULL'}
      Request.send(path: "/api/v1/trades", parameters: parameters)
  end

  # https://binance-docs.github.io/apidocs/futures/en/#cancel-order-trade
  def cancel_trade

  end

  # https://binance-docs.github.io/apidocs/futures/en/#cancel-order-trade
  def cancel_all_trade

  end

  # https://binance-docs.github.io/apidocs/futures/en/#futures-account-balance-v2-user_data
  def futures_account_balance

  end

  # https://binance-docs.github.io/apidocs/futures/en/#change-initial-leverage-trade
  # плечо
  def change_initial_leverage

  end
end


