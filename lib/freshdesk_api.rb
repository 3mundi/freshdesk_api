require "freshdesk_api/version"
require 'active_support/all'

module FreshdeskAPI
  include ActiveSupport::Configurable
  extend ActiveSupport::Autoload
  config_accessor :username
  config_accessor :password
  config_accessor :freshdesk_url
  config_accessor(:format) { :json }

  def self.setup
    yield(self)
  end

  autoload :Requester
  autoload :Resource
  autoload :Ticket
  autoload :Response
  autoload :Note
end
require 'http'
require 'virtus'
