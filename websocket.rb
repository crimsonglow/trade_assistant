module Binance
  class WebSocket
    class << self
      BASE_URL = 'wss://fstream.binance.com'

      # https://binance-docs.github.io/apidocs/futures/en/#mark-price-stream
      def mark_prise_stream_request
        EM.run do
          methods = { open: open,
                      error: error,
                      close: close }

          candlestick_streams_for_price(
            methods: methods.merge({ message: mark_price_stream_behavior })
          )

          EM.add_periodic_timer(1800) do
            keepalive
          end
        end
      end

      def candlestick_streams_for_price(methods:)
        passed_stream_url = "#{SkalpHelper.coin_symbol.downcase}@kline_1m"
        url = "#{BASE_URL}/ws/#{passed_stream_url}"
        create_stream url, methods: methods
      end
def mark_price_stream_behavior
        open_trade = false

        handle_behavior do |data|
          data_stream = data.dig(:k, :c).to_f

          if SkalpHelper.position_types == 'long'
             if data_stream > SkalpHelper.entry_price && open_trade == false
              puts 'open position to long'
              SkalpHelper.open_trade_long
              open_trade = true
            elsif data_stream > SkalpHelper.prise_take_position_long &&open_trade == true
              puts 'closed position in profit'
              SkalpHelper.close_trade_long
              exit
            elsif data_stream < SkalpHelper.prise_stop_position_long && open_trade == true
              puts 'closed position to stop'
              SkalpHelper.close_trade_long
              exit
            end
          end

          if SkalpHelper.position_types == 'short'
             if data_stream < SkalpHelper.entry_price && open_trade == false
              puts 'open position to short'
              SkalpHelper.open_trade_short
              open_trade = true
            elsif data_stream < SkalpHelper.prise_take_position_short &&open_trade == true
              puts 'closed position in profit'
              SkalpHelper.close_trade_short
              exit
            elsif data_stream > SkalpHelper.prise_stop_position_short && open_trade == true
              puts 'closed position to stop'
              SkalpHelper.close_trade_short
              exit
            end
          end



          # all order logic here.
        end
      end

      def test_keepalive
        loop do
          puts listen_key
          puts keepalive
          sleep(3000)
        end
      end

    private

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

    protected

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

      def handle_behavior(&block)
        proc do |e|
          data = JSON.parse(e.data, symbolize_names: true)

          yield(data)
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
