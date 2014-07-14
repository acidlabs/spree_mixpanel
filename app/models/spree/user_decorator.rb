module Spree

  User.class_eval do

    def mixpanel_track_user
      MixpanelTracker.track_user(email, mixpanel_fields.merge(mixpanel_personal_fields))
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
