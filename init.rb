require_relative 'lib//binance.rb'

request = Binance::SkalpHelper.new(transaction_details: ENV.to_hash)

request.start_skalp_helper
