module FreshdeskAPI
  class Ticket < Resource
    include Virtus.model
    def initialize(args = {})
      if args[:helpdesk_ticket]
        super args[:helpdesk_ticket]
      else
        super
      end
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

    # When updating
    attribute :status_name, String
    attribute :requester_status_name, String
    attribute :priority_name, String
    attribute :source_name, String
    attribute :requester_name, String
    attribute :responder_name, String

    def self.add_note(id, params = {})
      r = Requester.new(self)
      url = "#{r.entity_url(id)}/conversations/note"
      to_api = {}.tap { |h| h[:helpdesk_note] = params }
      res = r.as_response { r.conn.post(url, json: to_api) }
      Note.new(res.body)
    end

    def priority
      return @priority if @priority
      case priority_name
      when 'Low' then 1
      when 'Medium' then 2
      when 'High' then 3
      when 'Urgent' then 4
      else
        @priority
      end
    end

    def status
      return @status if @status
      case status_name
      when 'Open' then 2
      when 'Pending' then 3
      when 'Resolved' then 4
      when 'Closed' then 5
      else
        @status
      end
    end

    def source
      return @source if @source
      case source_name
      when 'Email' then 1
      when 'Portal' then 2
      when 'Phone' then 3
      when 'Forum' then 4
      when 'Twitter' then 5
      when 'Facebook' then 6
      when 'Chat' then 7
      else
        @source
      end
    end

    def self.wrapper_key
      :helpdesk_ticket
    end

  end
end
