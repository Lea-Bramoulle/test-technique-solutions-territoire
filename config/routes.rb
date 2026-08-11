Rails.application.routes.draw do
  resources :communes, only: %i[index show create update]
end