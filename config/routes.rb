scope 'projects/:project_id' do
  resources :newissuealerts, :except => :show
end