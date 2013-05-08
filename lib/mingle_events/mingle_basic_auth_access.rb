module MingleEvents

  # Supports fetching of Mingle resources using HTTP basic auth.
  # Please only use this class to access resources over HTTPS so
  # as not to send credentials over plain-text connections.
  class MingleBasicAuthAccess
    BASIC_AUTH_HTTP_WARNING = %{
WARNING!!!
It looks like you are using basic authentication over a plain-text HTTP connection.
We HIGHLY recommend AGAINST this practice. You should only use basic authentication over
a secure HTTPS connection. Instructions for enabling HTTPS/SSL in Mingle can be found at
<http://www.thoughtworks-studios.com/mingle/3.3/help/advanced_mingle_configuration.html>
WARNING!!
}
    attr_reader :base_url

    def initialize(base_url, username, password, http=Http)
      @base_url = base_url
      @username = username
      @password = password
      @http = http
    end

    def fetch_page(location)
      location = @base_url + location if location[0..0] == '/'
      @http.get(location) do |req|
        MingleEvents.log.warn(BASIC_AUTH_HTTP_WARNING) if URI.parse(location).scheme == 'http'
        req['authorization'] = basic_encode(@username, @password)
      end
    end

    private
    def basic_encode(account, password)
      'Basic ' + ["#{account}:#{password}"].pack('m').delete("\r\n")
    end
  end
end
