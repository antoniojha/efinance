WebFinance::Application.routes.draw do
  resources :advance_searches

  # You can have the root of your site routed with "root"

 resources :spendings
 get 'spendings/receipt/:id', to: 'spendings#receipt', as: 'spendings/receipt'
 resources :transaction_imports
 
 get "admin"=>'admin#index'
 controller :sessions do
    get 'login'=> :new
    get 'signin'=> :create
    delete 'logout'=> :destroy
 end
  
 get "overview"=>"profiles#new"
 controller :profiles do
   get 'overview'=> :new
   post 'overview'=> :create
 end
 controller :static_pages do
   get "demo" => :demo
   get "about" => :about
   get "contact" => :contact
   get "home" => :home
   get "blog" => :blog
   get "faq" =>:faq
 end
 root 'static_pages#home'
 resources :search_spendings
 
 resources :users
 match '/signup', to: 'users#new', via: 'get'
 
 match '/confirmation', to:'email_confirmation#new',via:'get'
 resources :email_confirmation
 
 resources :finance_plans

 resources :profiles
  
 resources :finance_items

 resources :temp_items

 resources :goals

 resources :recur_budgets
  
 resources :budget_plans
 resources :temp_budget_plans
 resources :protection_plans
 resources :emergency_plans
 resources :college_plans
 resources :retirement_plans
 resources :investment_plans
 resources :finance_goal

end
