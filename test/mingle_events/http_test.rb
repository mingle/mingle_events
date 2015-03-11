require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

module MingleEvents
  class HttpTest < MiniTest::Test
    def setup
      @http = MingleEvents::Http
    end

    def test_should_return_response_body_on_success_request
      stub_request(:get, "http://www.example.com/").
         to_return(:status => 200, :body => "abc")
      assert_equal 'abc', @http.get("http://www.example.com")
    end

    def test_should_raise_error_when_unauthorized
      stub_request(:get, "http://www.example.com/").
         to_return(:status => 403, :body => "Forbidden")
      assert_raises(HttpError) { @http.get("http://www.example.com") }
    end

    def test_should_raise_error_on_service_unavailable_response
      stub_request(:get, "http://www.example.com/").
         to_return(:status => 503, :body => "Overloaded")
      assert_raises(HttpError) { @http.get("http://www.example.com", 0, 1) }
    end

    def test_should_retry_on_service_unavailable_response
      stub_request(:get, "http://www.example.com/").
        to_return(:status => 503, :body => "Overloaded").then.
        to_return(:status => 200, :body => "abc")
      assert_equal 'abc', @http.get("http://www.example.com", 0, 1)
    end


    def test_should_raise_error_on_eof
      stub_request(:get, "http://www.example.com/").
        to_raise(EOFError)
      assert_raises(HttpError) { @http.get("http://www.example.com", 0, 1) }
    end

    def test_should_retry_on_eof
      stub_request(:get, "http://www.example.com/").
        to_raise(EOFError).then.
        to_return(:status => 200, :body => "abc")
      assert_equal 'abc', @http.get("http://www.example.com", 0, 1)
    end
  end
end
