class MixpanelOrdersWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Spree::Order.find(order_id)
    MixpanelTracker.track_order(order)
  end
end
