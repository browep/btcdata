require 'rubygems'
require 'test/unit'
require 'vcr'
require 'unit/vcr_loader'


class VCRTest < Test::Unit::TestCase
  def test_example_dot_com
    VCR.use_cassette('synopsis') do
      response = Net::HTTP.get_response(URI('http://www.iana.org/domains/example/'))
      assert_match /Example Domains/, response.body
    end
  end
end