Rails.application.routes.draw do
  root to: 'transactions#index'
  resources :transactions, only: [:index, :create] do
    member do
      get 'file_download'
      get 'initialize_import'
      get 'validation_failed'
      get 'summary'
      get 'timeout'
      post 'start_import'
    end
  end
  get 'safari' => 'mambu#safari'
  post 'payload' => 'payload#main'
  get 'unavailable' => 'availabilities#unavailable'
  get 'status' => 'availabilities#status'
  get 'install' => 'mambu#install'
end
