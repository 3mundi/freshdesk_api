module FreshdeskAPI
  class Resource
    class << self
      def index
        response = Requester.new(self).index
        response.body.map { |o| new(o) }
      end

      def create(params)
        to_api = {}.tap { |h| h[wrapper_key] = params }
        response = Requester.new(self).create(to_api)
        new(response.body[wrapper_key])
      end

      def show(id)
        response = Requester.new(self).show(id)
        new(response.body[wrapper_key])
      end

      def destroy(id)
        response = Requester.new(self).destroy(id)
        !!response.body.to_s.match(/deleted/)
      end

      def update(id, params = {})
        to_api = {}.tap { |h| h[wrapper_key] = params }
        response = Requester.new(self).update(id, to_api)
        new(response.body[name.demodulize.downcase.to_sym])
      end

      def wrapper_key
        "helpdesk_#{name.downcase}".to_sym
      end
    end
  end
end
