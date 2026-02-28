Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :posts do
      collection do
        get :select_options, defaults: { format: :json }
      end
    end
    resources :post_categories do
      collection do
        get :select_options, defaults: { format: :json }
      end
    end
  end
end
