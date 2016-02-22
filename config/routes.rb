PositionStrategy::Application.routes.draw do
  root to: 'home#index'

  resources :users, only: [:new, :create, :update]
  resources :sessions, only: [:new, :create] do
    collection do
      get 'logout' => 'sessions#destroy'
    end
  end
  get 'auth/:provider/callback', to: 'sessions#create_via_sns'

  scope :reset_password do
    get  'forgot_password', to: 'reset_password#forgot_form'
    post 'forgot_password', to: 'reset_password#send_mail'
    get  'reset_password',  to: 'reset_password#reset_form'
    post 'reset_password',  to: 'reset_password#reset'
  end

  namespace :jpn do
    scope :companies do
      get  ':number',          to: 'companies#show',    constraints: { number: /[0-9]+/ }
      get  ':number/:compare', to: 'companies#compare', constraints: { number: /[0-9]+/, compare: /[0-9]+/ }, as: 'compare'
      post 'compare',          to: 'companies#search_for_compare', as: 'search_for_compare'
      post 'favorite',         to: 'companies#add_favorite'
    end

    resources :industries, only: [:index, :show] do
      member do
        get 'annual_average',     to: 'industries#annual_average',     constraints: { id: /[0-9]+/ }
        get 'each_year_averages', to: 'industries#each_year_averages', constraints: { id: /[0-9]+/ }
        get 'companies',          to: 'industries#companies',          constraints: { id: /[0-9]+/ }
        get ':basis/ranking',     to: 'industries#ranking_of_basis',   constraints: { id: /[0-9]+/ }
      end
    end
  end

  namespace :us do
    scope :companies do
      get  ':symbol',              to: 'companies#show',    constraints: { symbol: /[A-Z]+/, compare: /[A-Z]+/ }
      get  ':symbol/:compare',     to: 'companies#compare', constraints: { symbol: /[A-Z]+/, compare: /[A-Z]+/ }, as: 'compare'
      get  ':symbol/achievements', to: 'companies#achievements'
      post 'compare',              to: 'companies#search_for_compare', as: 'search_for_compare'
    end

    resources :industries, only: [:index, :show] do
      member do
        get ':basis/each_year_averages', to: 'industries#each_year_averages', constraints: { id: /[0-9]+/ }
        get 'companies',                 to: 'industries#companies',          constraints: { id: /[0-9]+/ }
        get ':basis/ranking',            to: 'industries#ranking_of_basis',   constraints: { id: /[0-9]+/ }
      end
    end
  end

  resources :search, only: :index do
    collection do
      post '/',                 to: 'search#extract'
      get  'jpn_company_names', to: 'search#jpn_company_names'
      get  'us_company_names',  to: 'search#us_company_names'
      get  'all_company_names', to: 'search#all_company_names'
    end
  end

  scope :mypage do
    get '/',                        to: 'mypage#index', as: 'mypage'
    get 'profile_edit_smart_phone', to: 'mypage#profile_edit_smart_phone'
  end

  if Rails.env.production?
    get '*path', to: 'application#render_404'
  end
end
