module Spree
  Order.class_eval do
    after_update :mixpanel_track_order

    def mixpanel_track_order
      Mixpanel::EventHandler.new('event' => :order, 'order_id' => self.id).handle_event
    end

    def mixpanel_track_charges
      Mixpanel::EventHandler.new('event' => :charge, 'order_id' => self.id).handle_event
    end

    def mixpanel_fields
      {
        'Number' => number,
        'Total' => mixpanel_total,
        'State' => state,
        'User email' => email,
        'Payment state' => payment_state
      }
    end

    def mixpanel_charge_fields
      {}
    end

    def mixpanel_personalized_fields
      {}
    end

    def mixpanel_event_message
      new_record? ? "Order created" : "Order updated"
    end

    def mixpanel_total
      display_total.cents.to_f / 100
    end
  end
end
