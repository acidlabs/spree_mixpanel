module Spree

  Order.class_eval do

    def mixpanel_track_order
      MixpanelTracker.track_order(self)
    end

    def mixpanel_fields
      {
        'Number' => number,
        'Total' => total,
        'State' => state,
        'User email' => email,
        'Payment state' => payment_state
      }
    end

    def mixpanel_personal_fields
      {}
    end

    def mixpanel_event_message
      new_record? ? "Order created" : "Order updated"
    end
  end
end
