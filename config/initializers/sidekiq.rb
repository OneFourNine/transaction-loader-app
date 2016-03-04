Sidekiq.configure_server do |config|
  config.redis = { namespace: 'transaction_loader' }
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: 'transaction_loader' }
end
