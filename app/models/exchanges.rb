class Exchanges
  MtGox = 0
  TradeHill = 1

  def self.[](key)
    case key
      when 0
        return :mtgox
      when 1
        return :tradehill
      when :mtgox
        return 0
      when :tradehill
        return 1
      else
        raise "exchange type: #{key.inspect} could not be found"
    end
  end


end