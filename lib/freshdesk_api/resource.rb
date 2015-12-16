module FreshdeskAPI
  class Resource
    class << self
      def index
        Requester.new(self).index
      end

      def create(params)
        Requester.new(self).create(params)
      end

      def show(id)
        response = Requester.new(self).show(id)
        self.new(response.body[:helpdesk_ticket])
      end

      def destroy(id)
        Requester.new(self).destroy(id)
      end

      def update(id, params = {})
        Requester.new(self).update(id, params)
      end
    end
  end
end
