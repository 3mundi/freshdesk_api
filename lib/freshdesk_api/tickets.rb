module FreshdeskAPI
  class Tickets
    class << self
      def resource
        name.demodulize.downcase
      end
      alias_method :for_url, :resource

      def index
        Requester.new(self).index
      end

      def create(params)
        Requester.new(self).create(params)
      end

      def show(id)
        Requester.new(self).show(id)
      end
    end

    def resource
      self.class.resource
    end
    alias_method :for_url, :resource
  end
end
