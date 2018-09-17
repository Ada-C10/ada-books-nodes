Rails.application.routes.draw do
  get '/books', to: 'books#index'
  get '/books/:id', to: 'books#show'

  #delete '/books/:id', to: 'books#destroy'

  # get '/books/show'
  # get '/books/whozeewhatsit'
  # get '/authors', to: 'authors#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
