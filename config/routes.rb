Rails.application.routes.draw do
  
  namespace :connector do
    get 'orders/history'
  end

  name_regex = /[\w\d\-\.]+/
  
  root to: 'dashboard#index'

  
  scope 'admin' do
    use_doorkeeper
    namespace :oauth do
      resources :application_owners, only: [:index]  do
        collection do
          get ':appid/show' => 'application_owners#show', as: 'show'
          post ':appid/create' => 'application_owners#create', as: 'create'
          delete ':appid/destroy/:ownerid' => 'application_owners#destroy', as: 'destroy'
        end
      end
      
      resource :owner, only: [:index] do
        collection do
          get 'getlist/:providerid' => 'owners#getlist', as: 'getlist'
          get 'getlist_withoutselected/:providerid/:appid' => 'owners#getlist_withoutselected', as: 'getlist_withoutselected'
        end
      end
      
    end
  end

  namespace :admin do
    resources :adminusers
   end
  
  #devise_for :users
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }
    
  namespace :connector do
    resources :items , only: [] do
      collection do
        get :view
        get :viewall
        get :category
      end
    end
    resources :orders , only: [] do
       collection do
         get :history
       end
     end
  end

  
  resources :users, only: [:new, :create]
end
