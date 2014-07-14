module Spree
  class MixpanelConfiguration < Preferences::Configuration
    preference :connection_token, :string
  end
end
