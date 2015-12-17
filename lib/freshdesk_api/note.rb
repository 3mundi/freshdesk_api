module FreshdeskAPI
  class Note < Resource
    include Virtus.model
    def initialize(args = {})
      if args[:note]
        super args[:note]
      else
        super
      end
    end
    attribute :body, String
    attribute :body_html, String
    attribute :created_at, DateTime
    attribute :deleted, Boolean
    attribute :id, Integer
    attribute :incoming, Boolean
    attribute :private, Boolean
    attribute :source, Integer
    attribute :updated_at, DateTime
    attribute :user_id, Integer
    attribute :attachments, Array
    attribute :support_email, String
  end
end
