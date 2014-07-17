module Spree
  class MixpanelConfiguration < Preferences::Configuration
    preference :connection_token, :string
    preference :push_order_charges, :boolean, :default => true
  end
end
