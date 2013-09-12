module MingleEvents

  # Client for Mingle's API Key access.
  class MingleApiKeyAccess
    attr_reader :base_url

    def initialize(base_url, api_key)
      @base_url = base_url
      @api_key = api_key
    end

    def fetch_page(location)
      location  = @base_url + location if location[0..0] == '/'
      Http.get(location, 'MINGLE_API_KEY' => @api_key)
    end
  end
end
