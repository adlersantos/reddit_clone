RedditClone::Application.routes.draw do
  resources :users
  resources :subs
  resources :comments
  resources :links do
    resources :votes # do I even need this?
    get 'upvote', to: 'links#upvote'
    get 'downvote', to: 'links#downvote'
  end

  resource :session
end
