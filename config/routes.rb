Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/', to: redirect('api/v1/login/')

  namespace :api do
    namespace :v1 do
      get 'meeting/list'
      get 'meeting/new'
      get 'meeting/detail/:meeting_id', to: 'meeting#detail'
      post 'meeting/create'
      get 'meeting/edit/:meeting_id', to: 'meeting#edit'
      post 'meeting/update/:meeting_id', to: 'meeting#update'
      delete 'meeting/delete/:meeting_id', to: 'meeting#delete'
      get 'car/car_list'
      get 'car/repair_list/:number', to: 'car#repair_list'
      get 'car/new_car'
      post 'car/create_car'
      get 'car/xlsx_car_list'
      get 'car/xlsx_fuel_list/:car_id', to: 'car#xlsx_fuel_list'
      get 'car/xlsx_repair_list/:car_id', to: 'car#xlsx_repair_list'
      get 'car/xlsx_fuel_list_all'
      get 'car/xlsx_repair_list_all'
      get 'car/new_repair/:car_id', to: 'car#new_repair'
      post 'car/create_repair/:car_id', to: 'car#create_repair'
      get 'car/edit_car/:car_id', to: 'car#edit_car'
      post 'car/update_car/:car_id', to: 'car#update_car'
      post 'car/update_repair/:repair_id', to: 'car#update_repair'
      get 'car/edit_repair/:repair_id', to: 'car#edit_repair'
      get 'car/sell_car/:car_id', to: 'car#sell_car'
      post 'car/dispose_car/:car_id', to: 'car#dispose_car'
      post 'car/cancel_dispose/:car_id', to: 'car#cancel_dispose'
      get 'car/fuel_list/:car_id', to: 'car#fuel_list'
      get 'car/new_fuel/:car_id', to: 'car#new_fuel'
      get 'car/edit_fuel/:fuel_id', to: 'car#edit_fuel'
      post 'car/create_fuel/:car_id', to: 'car#create_fuel'
      post 'car/update_fuel/:fuel_id', to: 'car#update_fuel'
      post 'car/admit/:what/:id', to: 'car#admit'
      delete 'car/delete_repair/:repair_id', to: 'car#delete_repair'
      delete 'car/delete_fuel/:fuel_id', to: 'car#delete_fuel'
      get 'notification/list'
      get 'notification/open/:id', to: 'notification#open'
      get 'cashio/new'
      get 'cashio/new/:date', to: 'cashio#new'
      get 'cashio/new_base_balance'
      post 'cashio/create'
      post 'cashio/create_base_balance'
      get 'cashio/edit/:id', to: 'cashio#edit'
      post 'cashio/update/:id', to: 'cashio#update'
      delete 'cashio/delete/:id', to: 'cashio#delete'
      post 'cashio/admit/:id', to: 'cashio#admit'
      get 'cashio/day/:date', to: 'cashio#day'
      get 'cashio/search'
      get 'cashio/list'
      get 'cashio/calendar'
      get 'feedback/new'
      post 'feedback/create'
      post 'feedback/delete'
      patch 'feedback/update/:id', to: 'feedback#update'
      get 'event/new/:diary_id', to: 'event#new'
      post 'event/create'
      delete 'event/delete/:diary_id/:id', to: 'event#delete'
      patch 'event/update/:diary_id/:id', to: 'event#update'
      get 'diary/new'
      get 'diary/new/:date', to: 'diary#new'
      get 'diary/day/:date', to: 'diary#day'
      get 'diary/edit/:id', to: 'diary#edit'
      post 'diary/update3/:id', to: 'diary#update3'
      post 'diary/create3'
      get 'diary/list'
      # get 'diary/list/:page', to: 'diary#list'
      get 'diary/list/:year/:month', to: 'diary#list'
      get 'diary/calendar'
      get 'diary/back_up'
      delete 'diary/delete/:id', to: 'diary#delete'
      get 'diary/search'
      post 'diary/search'
      get 'diary/pdf/:id/:filename.pdf', to: 'diary#make_pdf', format: :pdf
      # get 'diary/pdf_template/:id', to: 'diary#pdf_template'
      get 'diary/detail/:id', to: 'diary#detail'
      post 'diary/admit/:id', to: 'diary#admit'
      post 'diary/de_admit/:id', to: 'diary#de_admit'
      get 'login/', to: 'login#sign_in'
      get 'login/sing_in/:user_name', to: 'login#sign_in'
      post 'login/login', to: 'login#login'
      get 'login/logout', to: 'login#logout'
      get 'login/sign_up', to: 'login#sign_up'
      get 'login/signed_up', to: 'login#signed_up'
      get 'login/wrong_admin_pw', to: 'login#wrong_admin_pw'
      get 'login/wrong_pw_check', to: 'login#wrong_pw_check'
      post 'login/signingup', to: 'login#signingup'
    end
  end
end
