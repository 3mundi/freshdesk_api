module FreshdeskAPI
  class Ticket < Resource
    include Virtus.model
    class Note
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
    attribute :display_id, Integer
    attribute :email, String
    attribute :phone, Integer
    attribute :twitter_id, String
    attribute :name, String
    attribute :requester_id, Integer
    attribute :subject, String
    attribute :description, String
    attribute :description_html, String
    attribute :status, Integer
    attribute :priority, Integer
    attribute :source, Integer
    attribute :deleted, Boolean
    attribute :spam, Boolean
    attribute :responder_id, Integer
    attribute :group_id, Integer
    attribute :ticket_type, String
    attribute :cc_emails, Array
    attribute :email_config_id, Integer
    attribute :isescalated, Boolean
    attribute :due_by, DateTime
    attribute :id, Integer
    attribute :attachments, Array
    attribute :custom_field, Hash

    # Only When Retriving
    attribute :created_at, DateTime
    attribute :deleted, Boolean
    attribute :delta, Boolean
    attribute :frDueBy, DateTime
    attribute :fr_escalated, Boolean
    attribute :group_id, Integer
    attribute :id, Integer
    attribute :isescalated, Boolean
    attribute :notes, [Note]

    def self.wrapper_key
      :helpdesk_ticket
    end

  end
end
