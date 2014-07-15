require 'mixpanel-ruby'

module MixpanelTracker

  def self.track_user(email, opts={})
    tracker.people.set(email, opts)
  end

  def self.track_order(order, options={})
    event_message = options[:event_message] || order.mixpanel_event_message
    tracker.track(order.email, event_message, order.mixpanel_fields.merge(order.mixpanel_personal_fields))
  end

  private
  def self.tracker
    validate_connection_token
    @tracker ||= Mixpanel::Tracker.new(connection_token)
  end

  def self.connection_token
    @token ||= Spree::Mixpanel::Config[:connection_token]
  end

  def self.validate_connection_token
    raise MixpanelApiError, "Mixpanel connection token is required" if !connection_token
  end

  class MixpanelApiError < StandardError; end
end
