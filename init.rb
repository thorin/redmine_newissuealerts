require 'redmine'

# Patches to the Redmine core.
RedmineApp::Application.config.after_initialize do
  require_dependency 'issue'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless Issue.included_modules.include? RedmineNewissuealerts::IssuePatch
    Issue.send(:include, RedmineNewissuealerts::IssuePatch)
  end

  require_dependency 'projects_helper'
  unless ProjectsHelper.included_modules.include? RedmineNewissuealerts::ProjectsHelperPatch
    ProjectsHelper.send(:include, RedmineNewissuealerts::ProjectsHelperPatch)
  end

  #Action mailer does not have the plugin directory, this may be removed later if redmine patches the plugin.rb file http://www.redmine.org/issues/11530
  ActionMailer::Base.prepend_view_path(File.join(File.dirname(__FILE__), 'app', 'views'))
end

# It requires the file in lib/redmine_newissuealerts/hooks.rb
require_dependency 'redmine_newissuealerts/hooks'

Redmine::Plugin.register :redmine_newissuealerts do
  name 'Redmine Newissuealerts plugin'
  author 'Emmanuel Bretelle'
  description 'Send an email to a list of addresses when a new issue is created'
  version '0.0.2'
  author_url 'http://www.debuntu.org'
  url 'http://redmine.debuntu.org/projects/redmine-newissuealerts'

  # This plugin adds a project module
  # It can be enabled/disabled at project level (Project settings -> Modules)
  project_module :newissuealerts do
    # These permissions has to be explicitly given
    # They will be listed on the permissions screen
    #
    # The commented line will make all elements public
    #permission :newissuealerts, {:newissuealerts => [:index, :edit, :new]}, :public => true
    #permission :view_newissuealerts, :newissuealerts => :index
    permission :edit_newissuealerts, {:projects => :settings, :newissuealerts => [:index, :edit, :update, :destroy]}, :require => :member
    permission :new_newissuealerts, {:projects => :settings, :newissuealerts => [:index, :new, :create]}, :require => :member
    permission :view_newissuealerts, {:projects => :settings, :newissuealerts => :index}, :require => :member
  end
  # A new item is added to the project menu
  #menu :project_menu, :newissuealerts, { :controller => 'newissuealerts', :action => 'index' }, :caption => 'New Issue Alerts', :after => :activity, :param => :project_id
  #menu :project_menu, :newissuealerts, { :controller => 'newissuealerts', :action => 'index' }, :caption => :newissuealert_menuitem, :param => :project_id
end
