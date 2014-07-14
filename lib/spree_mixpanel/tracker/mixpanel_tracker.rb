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
    @tracker ||= Mixpanel::Tracker.new(Spree::Mixpanel::Config[:connection_token])
  end
end
