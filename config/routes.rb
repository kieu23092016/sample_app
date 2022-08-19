Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get 'users/new'
    # get 'static_pages/help'
    get '/help',to: 'static_pages#help'
    get '/about', to: 'static_pages#about'
    get '/contact', to: 'static_pages#contact'
    get '/signup', to: 'users#new'
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root 'static_pages#home'
  end
end