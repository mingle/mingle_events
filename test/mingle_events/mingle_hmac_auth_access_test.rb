require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

module MingleEvents
  class MingleHmacAccessTest < Test::Unit::TestCase
    def setup
      @httpstub = HttpStub.new
      @access = MingleHmacAuthAccess.new("http://foo.bar.com", "login", "api-key", @httpstub)
    end

    def test_should_set_auth_header_for_hmac
      assert_equal "OK", @access.fetch_page("/index.html")
      assert @httpstub.last_request['Authorization'].start_with?("APIAuth")
    end
  end
end
