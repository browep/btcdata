require 'rubygems'
require 'test/unit'
require 'vcr'
require 'unit/vcr_loader'
require 'json'
require "net/https"
require "uri"
require 'test_helper'



class RecentTradesTest < ActiveSupport::TestCase
  def get_recent_trades
    uri = URI.parse("https://mtgox.com/code/data/getTrades.php")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    http.request(request)
  end

  def test_get_trades
    VCR.use_cassette('get_trades') do
      response = get_recent_trades()
      assert response.body.size > 10000
      assert JSON.parse(response.body)
    end
  end

  def test_parse_trade
    VCR.use_cassette('parse_trades') do
      response = get_recent_trades
      trades_data = JSON.parse response.body

      trades = []

      trades_data.each do |trade_entry|
        trades << Trade.new(
            :id=>trade_entry['tid'],
            :date=>Time.at(trade_entry['date']),
            :price=>trade_entry['price'].to_f,
            :amount=>trade_entry['amount'].to_f,
            :exchange=>:mtgox
        )
      end

      assert trades.size > 0
      assert trades[0].id == "1310066101233200"
      assert trades[0].date.year == 2011
      assert trades[0].date.to_i == 1310066101
      assert trades[0].price.instance_of? Float
      assert trades[0].amount.instance_of? Float
      assert trades[0].price == 15.34089
      assert trades[0].amount == 6.0
      assert trades[0].exchange == :mtgox
    end
  end


end