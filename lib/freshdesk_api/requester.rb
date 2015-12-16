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
      as_response do
        conn.get(entity_url(id))
      end
    end

    def update(id, params = {})
      as_response do
        conn.put(entity_url(id), json: params)
      end
    end

    def destroy(id)
      conn.delete(entity_url(id))
    end

    def url
      URI.join(FreshdeskAPI.freshdesk_url, '/helpdesk/', "#{resource.for_url}").to_s
    end

    def entity_url(id)
      "#{url}/#{id}"
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
