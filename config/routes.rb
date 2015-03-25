Dre::Engine.routes.draw do
  get 'devices/', to: 'devices#index'
  put 'devices/:token', to: 'devices#register'
  delete 'devices/:token', to: 'devices#deregister'
end
