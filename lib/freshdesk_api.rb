require "freshdesk_api/version"
require 'active_support/all'
require 'http'
require 'virtus'

module FreshdeskAPI
  include ActiveSupport::Configurable
  config_accessor :username
  config_accessor :password
  config_accessor :freshdesk_url
  config_accessor(:format) { :json }

  def self.setup
    yield(self)
  end
end

require 'freshdesk_api/requester'
require 'freshdesk_api/resource'
require 'freshdesk_api/ticket'
require 'freshdesk_api/response'
