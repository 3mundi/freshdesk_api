module FreshdeskAPI
  Response = Struct.new(:request) do
    delegate :status, to: :request
    def body
      case FreshdeskAPI.format
      when :json
        JSON.parse(request.body, symbolize_names: true)
      else
        request.body
      end
    end
  end
end
