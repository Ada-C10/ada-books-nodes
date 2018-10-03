Rails.application.routes.draw do
  root "books#index"

  resources :books

  resources :authors do
    resources :books, only: [:index, :new]
  end

  # get '/authors/:id', to: 'authors#show', as: 'author'

  # get '/books', to: 'books#index', as: 'books'
  #
  # get '/books/new', to: 'books#new', as: 'new_book'
  # post '/books', to: 'books#create'
  #
  # get '/books/:id/edit', to: 'books#edit', as: 'edit_book'
  #
  # get '/books/:id', to: 'books#show', as: 'book'
  #
  # patch '/books/:id/complete', to: 'books#mark_complete', as: 'mark_complete'
  #
  # patch '/books/:id', to: 'books#update', as: 'update_book'
  # put '/books/:id', to: 'books#update'
  #
  # delete '/books/:id', to: 'books#destroy'

  #delete '/books/:id', to: 'books#destroy'

  # get '/books/show'
  # get '/books/whozeewhatsit'
  # get '/authors', to: 'authors#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
