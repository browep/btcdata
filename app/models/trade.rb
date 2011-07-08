require 'default_settable'
require 'exchanges'

class Trade
  include DefaultSettable
  attr_accessor :date,:price,:amount,:id,:currency,:exchange

  def initialize options
    super
    if exchange.nil?
      raise "You must supply an exchange through the :exchange option"
    end

  end

  def to_archive
    "#{id},#{date.to_i},#{price},#{amount},#{currency},#{Exchanges[exchange]}"
  end

  def self.from_archive(line)
    id,date,price,amount,currency,exchange = line.split(",")
    price = price.to_f
    amount = amount.to_f
    currency = currency.nil? || currency.size == 0 ? "USD" : currency
    exchange = Exchanges[exchange.to_i]
    date = Time.at(date.to_i)
    Trade.new(:id=>id,:price=>price,:amount=>amount,:currency=>currency,:exchange=>exchange,:date=>date)
  end



end