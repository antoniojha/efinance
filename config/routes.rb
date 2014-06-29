WebFinance3::Application.routes.draw do
  # You can have the root of your site routed with "root"

 resources :spendings

 # get "admin"=>'admin#index'
 controller :sessions do
    get 'login'=> :new
    post 'login'=> :create
    delete 'logout'=> :destroy
 end
  
 #get "overview"=>"profiles#new"
 controller :profiles do
   get 'overview'=> :new
   post 'overview'=> :create
 end
  root 'users#new'
 # resources :search_spending
  resources :users

 # resources :finance_plans

 resources :profiles
  
 # resources :finance_items

 # resources :temp_items

 # resources :goals

 # resources :recur_budgets
  
 # resources :budget_plans
 # resources :temp_budget_plans
 # resources :protection_plans
 # resources :emergency_plans
 # resources :college_plans
 # resources :retirement_plans
 # resources :investment_plans
 # resources :finance_goal

end
