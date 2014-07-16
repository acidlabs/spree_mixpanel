module Spree

  User.class_eval do

    def mixpanel_track_user
      Mixpanel::EventHandler.new('event' => :user, 'user_email' => self.email, 'user_opts' => mixpanel_opts).handle_event
    end

    def mixpanel_opts
      mixpanel_fields.merge(mixpanel_personal_fields)
    end

    def mixpanel_personal_fields
      {}
    end

    def mixpanel_fields
      {
        '$first_name'       => first_name,
        '$last_name'        => last_name,
        '$email'            => email
      }
    end
  end
end
