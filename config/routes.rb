Monologue::Engine.routes.draw do
  root to:  "posts#index"
  match "/page/:page", to:  "posts#index", as:  "posts_page"
  match "/feed" => "posts#feed", as:  "feed", defaults: {format: :rss}

  match "/tags/:tag" =>"tags#show", as: "tags_page"

  namespace :admin, path: "monologue" do
    get "/" => "posts#index", as:  "" # responds to admin_url and admin_path
    get "logout" => "sessions#destroy"
    get "login" => "sessions#new"
    resources :sessions
    resources :posts
    resources :users
    get "comments" => "comments#show", as: "comments"

    get "cache" => "cache#show", as: "cache"
    delete "cache" => "cache#destroy"
    
    match "/post/preview"=>"posts#preview", :as=>"post_preview", :via => [:put, :post]
  end

  match "*post_url" => "posts#show", as:  "post"
end