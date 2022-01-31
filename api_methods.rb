require 'httparty'
require 'open-uri'
require 'json'
require_relative 'signaturebuilder'

module ApiMethods

  URL = 'https://fapi/binance.com'

  # https://binance-docs.github.io/apidocs/futures/en/#market-data-endpoints
  def ping

  end

  # https://binance-docs.github.io/apidocs/futures/en/#check-server-time
  def check_server_time

  end

  # https://binance-docs.github.io/apidocs/futures/en/#exchange-information
  def exchange_information

  end

  # https://binance-docs.github.io/apidocs/futures/en/#symbol-price-ticker
  def check_price

  end

  # https://binance-docs.github.io/apidocs/futures/en/#new-order-trade
  def new_trade(coin:, purchase_type:, type_trade: 'LIMIT_MAKER', quantity_coin:, coin_price:)
    symbol = coin
    side = purchase_type
    type = type_trade
    quantity = quantity_coin
    timestamp
    timeInForce = 'IOC'
    price = coin_price
    newOrderRespType = 'FULL'
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

  def get

  end

  def post

  end
end

