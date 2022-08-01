require 'rubygems'
require 'test/unit'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

class TaskControllerTest < Test::Unit::TestCase
  def test
    get '/'
    VCR.use_cassette('synopsis') do
      response = Net::HTTP.get_response(URI('https://api.github.com/users/dbb'))
      resUsername = response['data']['user']['name']
      assert_match '/', resUsername
    end
  end
end