class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #
  #
  #before_filter :get_users
  #before_filter :get_projects
  #
  #def get_users
  #  @users = Users.all(:limit => 100)
  #end
  #
  #def get_projects
  #  @projects = Projects.all(:limit => 100)
  #end
  #
  #def get_latest_bugs
  #  @bugs = Bugs.all(:order => 'date DESC, user ASC, project ASC', :limit => 1000)
  #end
end
