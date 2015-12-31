module FreshdeskAPI
  Response = Struct.new(:request) do
    delegate :status, to: :request
    def body
      return if status == 404
      case FreshdeskAPI.format
      when :json
        JSON.parse(request.body, symbolize_names: true)
      else
        request.body
      end
    end
  end
end
