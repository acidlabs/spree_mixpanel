require 'spec_helper'

module MixpanelTracker
  describe MixpanelTracker do

    let (:config) { Spree::Mixpanel::Config }

    it "is invalid without a connection token" do
      config[:connection_token] = nil
      expect { MixpanelTracker.tracker }.to raise_error(MixpanelApiError)
    end

    it "is valid with a connection token" do
      config[:connection_token] = "TOKEN"
      expect { MixpanelTracker.tracker }.to_not raise_error
    end

  end
end
