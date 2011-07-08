require "json"

class MtGoxConnector
  @@recent_trades_uri = URI.parse("https://mtgox.com/code/data/getTrades.php")

  def get_latest_trades
    http = Net::HTTP.new(@@recent_trades_uri.host, @@recent_trades_uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(@@recent_trades_uri.request_uri)

    response = http.request(request)
    JSON.parse(response.body)

  end
end