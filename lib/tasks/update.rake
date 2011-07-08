require "exchange_connector"

namespace :update do
  task :mtgox => :environment do
    Rails.logger.auto_flushing=true

    num_added = 0

    # get the latest trades from the file
    last_line = nil
    Elif.open(APP_CONFIG[:data_file]) do |f|
      last_line = f.readline.strip
    end

    # create trade from last line
    last_known_trade = last_line ? Trade.from_archive(last_line) : nil

    # get recent trades
    mtgox = MtGoxConnector.new
    latest_trades = mtgox.get_latest_trades
    File.open(APP_CONFIG[:data_file], "a") do |f|
      latest_trades.each do |trade_entry|
        # if the time stamp is after the last_known_trade, append it to the file
        trade = Trade.new(
            :id=>trade_entry['tid'],
            :date=>Time.at(trade_entry['date']),
            :price=>trade_entry['price'].to_f,
            :amount=>trade_entry['amount'].to_f,
            :exchange=>:mtgox
        )

        if last_known_trade.nil? || trade.date > last_known_trade.date
          f.puts(trade.to_archive)
          num_added += 1
        end

      end
    end

    Rails.logger.info("added #{num_added} trades")
  end
end
