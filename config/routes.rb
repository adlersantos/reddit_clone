RedditClone::Application.routes.draw do
  resources :users
  resources :subs
  resources :comments
  resources :links do
    post 'upvote', to: 'links#upvote'
    post 'downvote', to: 'links#downvote'
  end

  resource :session
end
