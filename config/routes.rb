Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get('/about', {to:'about#index'})
  get('/contact', {to:'contact#index'})

  post('/contact', {to:'contact#create', as:'contact_submit'})

#   delete '/questions/:id', to:'questions#destroy'
#   (HTTP Verb: get - path: /questions/:id/edit ) ==> questions controller / edit action
#   get '/questions/:id/edit', to:'questions#edit'
# (HTTP Verb: get - path: /questions/:id ) ==> questions controller / show action
#   get '/questions/:id', to:'questions#show'
# (HTTP Verb: post - path: /questions/:id/comments ) ==> comments controller / create action
#   post '/questions/:id/comments', to:'comments#create'
# (HTTP Verb: get - path: /faq ) ==> home controller / faq action
#   get '/faq', to:'home#faq'
  resources :products do
    resources :favourites, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy], shallow: true  do
      resources :likes, only: [:create, :destroy]
    end
  end

  # resources :reviews, only: :none do
  #   resources :likes, only: [:index, :create, :destroy]
  # end
  #


  resources :users, only:[:new, :create] do
    resources :favourites, only: [:index] 
  end
  resources :sessions, only:[:new, :create] do
    delete :destroy, on: :collection
    #password does not show in the address url
  end
  get('/admin/dashboard', {to: 'admin/dashboard#index'})
  # get('/products/new', {to: 'products#index', as:'products'})
end
