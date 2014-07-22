module Spree
  module Mixpanel
    class EventHandler

      def initialize(opts)
        @opts = opts
        @event = opts["event"].try(:to_sym)
        @user_email = opts["user_email"]
        @order_id = opts["order_id"]
      end

      def handle_event
        if has_sidekiq?
          SpreeMixpanelWorker.perform_async(opts)
        else
          mixpanel_perform
        end
      end

      def mixpanel_perform
        case event
        when :user
          MixpanelTracker.track_user(user_email)
        when :order
          MixpanelTracker.track_order(order_id)
        when :charge
          MixpanelTracker.track_charge(order_id)
        end
      end

      private

      attr_reader :opts, :event, :user_email, :order_id

      def has_sidekiq?
        @has_sidekiq ||= begin
                           require 'sidekiq'
                           true
                         rescue LoadError
                           false
                         end
      end
    end
  end
end
