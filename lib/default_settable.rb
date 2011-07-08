
module DefaultSettable
  def initialize values
    values.each_pair do |k,v|
      self.send("#{k}=",v)
    end
  end
end