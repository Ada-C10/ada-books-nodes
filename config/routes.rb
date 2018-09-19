Rails.application.routes.draw do
  root "books#index"

  get '/books', to: 'books#index', as: 'books'

  get '/books/new', to: 'books#new', as: 'new_book'
  post '/books', to: 'books#create'

  get '/books/:id/edit', to: 'books#edit', as: 'edit_book'

  get '/books/:id', to: 'books#show', as: 'book'

  patch '/books/:id', to: 'books#update'
  put '/books/:id', to: 'books#update'

  delete '/books/:id', to: 'books#destroy'

  #delete '/books/:id', to: 'books#destroy'

  # get '/books/show'
  # get '/books/whozeewhatsit'
  # get '/authors', to: 'authors#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
