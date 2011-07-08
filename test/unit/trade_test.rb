require 'rubygems'
require 'test/unit'
require 'test_helper'


class TradeTest < ActiveSupport::TestCase

  def test_trade_to_archive
    trade = Trade.new(
        :id=>"123456",
        :date=>Time.at(1310066101),
        :price=>10.1,
        :amount=>5.05,
        :exchange=>:mtgox
    )
    assert trade.to_archive == "123456,1310066101,10.1,5.05,,0"

    trade = Trade.new(
        :id=>"123456",
        :date=>Time.at(1310066101),
        :price=>10.1,
        :amount=>5.05,
        :exchange=>:mtgox
    )
    assert trade.to_archive == "123456,1310066101,10.1,5.05,,0"
  end

  def test_from_archive
    line = "654321,1310066001,10.1,5.05,,0"
    trade = Trade.from_archive(line)
    assert trade.id == "654321"
    assert trade.date == Time.at(1310066001)
    assert trade.price == 10.1
    assert trade.amount == 5.05
    assert trade.currency == "USD"
    assert trade.exchange == :mtgox
  end

end
