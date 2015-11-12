Spree::Core::Engine.add_routes do
  #devise_for :spree_user,
  #           class_name: Spree.user_class,
  #           only: [:omniauth_callbacks],
  #           controllers: { omniauth_callbacks: 'spree/omniauth_callbacks' },
  #           path: Spree::SocialConfig[:path_prefix]

  devise_scope :spree_user do
    match "/users/auth/:action/callback",
      constraints: { action: /google|facebook|amazon/ },
      to: "omniauth_callbacks",
      as: :spree_user_omniauth_callback_backup,
      via: [:get, :post]
  end

  resources :user_authentications

  get 'account' => 'users#show', as: 'user_root'

  namespace :admin do
    resources :authentication_methods
  end
end
