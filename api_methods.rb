module Binance
  class ApiMethods
    class << self

      # https://binance-docs.github.io/apidocs/futures/en/#market-data-endpoints
      def ping
        Request.send(path: '/fapi/v1/ping')
      end

      # https://binance-docs.github.io/apidocs/futures/en/#check-server-time
      def check_server_time
        Request.send(path: '/fapi/v1/time')
      end

      # https://binance-docs.github.io/apidocs/futures/en/#exchange-information
      def exchange_information
        Request.send(path: '/fapi/v1/exchangeInfo')
      end

      # https://binance-docs.github.io/apidocs/futures/en/#symbol-price-ticker
      def check_price(symbol:)
        parameters = {symbol: symbol}
        Request.send(path: '/fapi/v1/ticker/price', parameters: parameters)
      end

      # https://binance-docs.github.io/apidocs/futures/en/#new-order-trade
      def create_trade(symbol:, side:, type: 'MARKET', quantity: nil, price: nil, timeInForce: 'GTC')
        parameters = {
          symbol: symbol,
          side: side, # 'BUY', 'SELL'
          type: type,
          quantity:  quantity,
          price: price,
          timeInForce: timeInForce,
          newOrderRespType: 'FULL'
        }
          Request.send(method: :post, path: "/fapi/v1/order", parameters: parameters)
      end

      # https://binance-docs.github.io/apidocs/futures/en/#cancel-order-trade
      def cancel_trade(symbol:)
        parameters = {
          symbol: symbol
          # orderId: orderId
        }
        Request.send(method: :delete, path: '/fapi/v1/order', parameters: parameters)
      end

      # https://binance-docs.github.io/apidocs/futures/en/#cancel-order-trade
      def cancel_all_trades(symbol:)
        parameters = {symbol: symbol}
        Request.send(method: :delete, path: '/fapi/v1/allOpenOrders', parameters: parameters)
      end

      # https://binance-docs.github.io/apidocs/futures/en/#futures-account-balance-v2-user_data
      def futures_account_balance
        Request.send(path: '/fapi/v2/balance')
      end

      # https://binance-docs.github.io/apidocs/futures/en/#change-initial-leverage-trade
      # плечо
      def change_initial_leverage(symbol:, leverage: 11)
        parameters = {
          symbol: symbol,
          leverage: leverage}
        Request.send(method: :post, path: '/fapi/v1/leverage', parameters: parameters)
      end
    end
  end
end
