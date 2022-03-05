module Binance
  class WebSocket
    class << self
      BASE_URL = 'wss://fstream.binance.com'

      # https://binance-docs.github.io/apidocs/futures/en/#mark-price-stream
      def stream_request(stream__behavior:, coin_symbol:)
        puts Time.new
        listen_key

        EM.run do
          methods = { open: open,
                      error: error,
                      close: close }

          candlestick_streams_for_mark_price(coin_symbol: coin_symbol, methods: methods.merge({ message: stream__behavior }))

          EM.add_periodic_timer(1500) do
             keepalive
          end
        end
      end

    protected

      def candlestick_streams_for_mark_price(methods:, coin_symbol:)
        passed_stream_url = "#{coin_symbol.downcase}@kline_1m"
        url = "#{BASE_URL}/ws/#{passed_stream_url}"
        create_stream url, methods: methods
      end

      def listen_key
        Request.send(method: :post, path: "/fapi/v1/listenKey")['listenKey']
      end

      def keepalive
        Request.send(method: :put, path: "/fapi/v1/listenKey",
        parameters: { listenKey: listen_key })
      end

      def close
        Request.send(method: :delete, path: "/fapi/v1/listenKey",
        parameters: { listenKey: listen_key })
      end

    private

      def attach_methods(websocket, methods)
        methods.each_pair do |key, method|
          websocket.on(key) { |event| method.call(event) }
        end
      end

      def create_stream(url, methods:)
        Faye::WebSocket::Client.new(url).tap do |ws|
          attach_methods(ws, methods)
        end
      end

      def open
        proc do
          puts 'connected'

          yield if block_given?
        end
      end

      def error
        proc { |e| puts e }
      end

      def close
        proc { puts 'CLOSED' }
      end

    end
  end
end
