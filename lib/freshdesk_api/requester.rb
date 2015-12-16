module FreshdeskAPI
  Requester = Struct.new(:resource) do
    def index
      as_response do
        conn.get(url)
      end
    end

    def create(params = {})
      as_response do
        conn.post(url, json: params)
      end
    end

    def show(id)
      show_url = url.gsub(/.#{FreshdeskAPI.format}$/,"/#{id}.#{FreshdeskAPI.format}")
      as_response do
        conn.get(show_url, params: { id: id })
      end
    end

    def url
      URI.join(FreshdeskAPI.freshdesk_url, '/helpdesk/', "#{resource.for_url}.#{FreshdeskAPI.format}").to_s
    end

    private

    def as_response
      Response.new(yield)
    end

    def conn
      HTTP.basic_auth(user: FreshdeskAPI.username, pass: FreshdeskAPI.password)
        .accept(FreshdeskAPI.format)
    end
  end
end
