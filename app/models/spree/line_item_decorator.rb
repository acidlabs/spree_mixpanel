module Spree
  LineItem.class_eval do
    after_create  :mixpanel_track_cart_add
    after_destroy :mixpanel_track_cart_remove

    def mixpanel_track_cart_add
      Mixpanel::EventHandler.new(mixpanel_event_handler_params('Item added to cart')).handle_event
    end

    def mixpanel_track_cart_remove
      Mixpanel::EventHandler.new(mixpanel_event_handler_params('Item removed from cart')).handle_event
    end

    def mixpanel_opts
      mixpanel_fields.merge(mixpanel_personalized_fields)
    end

    def mixpanel_fields
      {
        'Order number' => order.number,
        'Name' => name,
        'Price' => total.to_s,
        'Quantity' => quantity
      }
    end

    def mixpanel_personalized_fields
      {}
    end

    private
      def mixpanel_event_handler_params name
        {
          'event' => :track,
          'user_email' => order.email,
          'event_name' => name,
          'event_opts' => mixpanel_opts
        }
      end
  end
end
