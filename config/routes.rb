Rails.application.routes.draw do
  resources :attempts
  resources :subgenres
  resources :questions
  resources :genres
  resources :destroys
  resources :users 
 # get 'admin/index'

  #get 'sessions/new'
  #root 'welcome#index'
  get 'sessions/create'

  get 'sessions/destroy'

  

  get 'admin' => 'admin#index'

  get 'homepage' => 'play#homepage'

  controller :sessions do
  	get 'login' => :new
  	post 'login' => :create
  	get 'logout' => :destroy
  end

  controller :subgenres do
    get '/getsubgenres' => :getsubgenres
  end

  controller :play do
    post "/play" => :index
    get '/play' => :gotohomepage
    get "/updateattempt" => :updateattempt
    get "/getquestion" => :getquestion
    get "/leader" => :leaderboard
    get "/adminleader" => "attempts#leaderboard"
    get "/loadll" => :loadll
    get "/quizstatus" => "play#quizstatus"
    get "/chart" => "play#chart"
    get "/getchart" => :getchart
  end
  
  root :to => redirect("/login")

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
