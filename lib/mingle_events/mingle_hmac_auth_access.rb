module MingleEvents
  # Client for Mingle's experimental HMAC api auth support
  class MingleHmacAuthAccess
    attr_reader :base_url

    def initialize(base_url, login, api_key, http=HTTP)
      @base_url = base_url
      @login = login
      @api_key = api_key
      @http = http
    end

    def fetch_page(location)
      location  = @base_url + location if location[0..0] == '/'
      @http.get(location) do |req|
        ApiAuth.sign!(req, @login, @api_key)
      end
    end
  end


end
