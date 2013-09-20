Maslow::Application.routes.draw do
  resources :needs

  root :to => redirect('/needs')
end
