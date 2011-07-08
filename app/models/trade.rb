require 'default_settable'

class Trade
  include DefaultSettable
  attr_accessor :date,:price,:amount,:id,:currency,:exchange

  def to_archive
    "#{id},#{date.to_i},#{price},#{amount},#{currency},#{exchange}"
  end

end