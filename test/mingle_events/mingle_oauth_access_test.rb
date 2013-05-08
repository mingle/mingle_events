require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

module MingleEvents
  class MingleOauthAccessTest < Test::Unit::TestCase
    def setup
      @httpstub = HttpStub.new
      @access = MingleOauthAccess.new("http://foo.bar.com", "some-token", @httpstub)
    end

    def test_should_set_auth_header_for_with_oauth_token
      assert_equal "OK", @access.fetch_page("/index.html")
      assert @httpstub.last_request['Authorization'].start_with?("Token")
    end
  end
end
