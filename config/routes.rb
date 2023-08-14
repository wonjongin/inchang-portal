Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/', to: redirect('api/v1/login/')

  namespace :api do
    namespace :v1 do
      get 'feedback/new'
      post 'feedback/create'
      patch 'feedback/update/:id', to: 'feedback#update'
      get 'event/new/:diary_id', to: 'event#new'
      post 'event/create'
      delete 'event/delete/:diary_id/:id', to: 'event#delete'
      patch 'event/update/:diary_id/:id', to: 'event#update'
      get 'diary/new'
      get 'diary/new/:date', to: 'diary#new'
      get 'diary/edit/:id', to: 'diary#edit'
      post 'diary/update/:id', to: 'diary#update'
      post 'diary/update3/:id', to: 'diary#update3'
      post 'diary/create'
      post 'diary/create2'
      post 'diary/create3'
      get 'diary/list'
      get 'diary/list/:page', to: 'diary#list'
      get 'diary/list_my_diaries'
      get 'diary/list_of_unadmitted'
      get 'diary/calendar'
      get 'diary/back_up'
      delete 'diary/delete/:id', to: 'diary#delete'
      get 'diary/search'
      post 'diary/search'
      get 'diary/pdf/:id/:filename.pdf', to: 'diary#make_pdf', format: :pdf
      # get 'diary/pdf_template/:id', to: 'diary#pdf_template'
      get 'diary/my', to: 'diary#my_diaries'
      get 'diary/detail/:id', to: 'diary#detail'
      post 'diary/admit/:id', to: 'diary#admit'
      get 'login/', to: 'login#sign_in'
      get 'login/sing_in/:user_name', to: 'login#sign_in'
      post 'login/login', to: 'login#login'
      get 'login/logout', to: 'login#logout'
      get 'login/sign_up', to: 'login#sign_up'
      get 'login/signed_up', to: 'login#signed_up'
      get 'login/wrong_admin_pw', to: 'login#wrong_admin_pw'
      get 'login/wrong_user_pw', to: 'login#wrong_user_pw'
      get 'login/wrong_pw_check', to: 'login#wrong_pw_check'
      post 'login/signingup', to: 'login#signingup'
    end
  end
end
