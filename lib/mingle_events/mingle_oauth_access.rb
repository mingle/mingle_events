module MingleEvents

  # Client for Mingle's experimental OAuth 2.0 support in 3.0
  class MingleOauthAccess
    attr_reader :base_url

    def initialize(base_url, token, http=HTTP)
      @base_url = base_url
      @token = token
      @http = http
    end

    def fetch_page(location)
      location  = @base_url + location if location[0..0] == '/'
      @http.get(location) do |req|
        req['Authorization'] = %{Token token="#{@token}"}
      end
    end
  end
end
