Rails.application.routes.draw do
  
  get "/cookies", to: "app_cookies#show"
  get "/cookies/create/:data", to: "app_cookies#create"

  #using get all through so as we can plug into the browser directly

  get "/sessions", to: "app_session#show"
  get "/sessions/create/:uid", to: "app_session#create"
  get "/sessions/create_other/:username", to: "app_session#create_other"

  post "/people/login", to: "people#login"
  delete "/people/logout", to: "people#logout"
  get "/people/show", to: "people#show"

end
