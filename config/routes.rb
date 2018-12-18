Rails.application.routes.draw do
 devise_for :users
 resources :groups do
   resources :posts do
     member do
      post "like" => "posts#like"
      post "unlike" => "posts#unlike"
     end
   end
 end
 root 'groups#index'
end
