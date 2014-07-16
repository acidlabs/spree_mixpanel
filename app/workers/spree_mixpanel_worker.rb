class SpreeMixpanelWorker
  include Sidekiq::Worker

  def perform(opts={})
    Spree::Mixpanel::EventHandler.new(opts).mixpanel_perform
  end
end

