module Spree
  ProductsController.class_eval do
    after_filter :mixpanel_track_search, only: :index

    private
      def mixpanel_track_search
        if params[:keywords].present?
          Mixpanel::EventHandler.new(mixpanel_event_handler_params).handle_event
        end
      end

      def mixpanel_event_handler_params
        {
          'event'      => :track,
          'user_email' => spree_current_user.try(:email) || '',
          'event_name' => 'Product search',
          'event_opts' => { keywords: params[:keywords] }
        }
      end
  end
end
