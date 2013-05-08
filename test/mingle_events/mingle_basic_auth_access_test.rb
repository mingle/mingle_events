require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

module MingleEvents
  class MingleBasicAuthAccessTest < Test::Unit::TestCase
    def setup
      @httpstub = HttpStub.new
      @access = MingleBasicAuthAccess.new("http://foo.bar.com", "foo", "bar", @httpstub)
    end

    def test_should_set_auth_header_for_basic_authentication
      assert_equal "OK", @access.fetch_page("/index.html")
      assert @httpstub.last_request['Authorization'].start_with?("Basic")
    end
  end
end
