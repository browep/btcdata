require 'rubygems'
require 'test/unit'
require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
#  c.stub_with :webmock # or :fakeweb
  c.stub_with :fakeweb
end
