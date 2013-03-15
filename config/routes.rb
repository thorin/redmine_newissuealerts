RedmineApp::Application.routes.draw do
	match 'projects/:project_id/newissuealerts/:action', :to => 'newissuealerts'
  match 'projects/:project_id/newissuealerts/:action/:id', :to => 'newissuealerts'
  #map.connect 'projects/:project_id/newissuealerts/:action', :controller => 'newissuealerts'
	#map.connect 'projects/:project_id/newissuealerts/:action/:id', :controller => 'newissuealerts'
end
