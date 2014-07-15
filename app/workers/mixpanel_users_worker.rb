class MixpanelUsersWorker
  include Sidekiq::Worker

  def perform(user_email, opts={})
    MixpanelTracker.track_user(user_email, opts)
  end
end
