require 'mixpanel-ruby'

module MixpanelTracker

  def self.track_user(email, opts)
    tracker.people.set(email, opts)
  end

  def self.track_order(order_id)
    order = Spree::Order.find(order_id)
    tracker.track(order.email, order.mixpanel_event_message, order.mixpanel_fields.merge(order.mixpanel_personal_fields))
    track_charge(order.id) if push_order_charges? && order.paid?
  end

  def self.track_charge(order_id)
    order = Spree::Order.find(order_id)
    tracker.people.track_charge(order.email, order.mixpanel_total, order.mixpanel_charge_fields)
  end

  class MixpanelApiError < StandardError; end

  private
  def self.tracker
    validate_connection_token
    @tracker ||= Mixpanel::Tracker.new(connection_token)
  end

  def self.connection_token
    Spree::Mixpanel::Config[:connection_token]
  end

  def self.push_order_charges?
    @push_charges ||= Spree::Mixpanel::Config[:push_order_charges]
  end

  def self.validate_connection_token
    raise MixpanelApiError, "Mixpanel connection token is required" if !connection_token.present?
  end
end
