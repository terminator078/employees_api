Rails.application.routes.draw do
  namespace 'apis', defaults: { format: :json } do
    resources :employees
    resources :login, only: %i(index)
    resources :logout, only: %i(index)
    resources :register, only: %i(create)
    resources :tasks, only: %i(create update delete)
  end
end
