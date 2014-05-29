class ManagerController < ApplicationController

  http_basic_authenticate_with :name => "manager", :password => "manager"

  def index
    @menus = Menus.all(:order => 'position ASC', :limit => 1000)
  end

  def addmenu
    if request.post?
      if valid_params?
        b = Menus.new
        b.title = params[:title]
        b.save
        redirect_to manager_index_path
      end
    end
  end

  def addsubmenu
    if request.post?
      if valid_params_submenu?
        b = Submenus.new
        b.title = params[:title]
        b.menu = params[:menu]
        b.save
        redirect_to manager_index_path
      end
    end
  end


  def deletemenu
    id = params[:menu]
    bug = Menus.find_by_id(id)
    bug.destroy if bug
    redirect_to manager_index_path
  end

  def deletesubmenu
    id = params[:menu]
    bug = Submenus.find_by_id(id)
    bug.destroy if bug
    redirect_to manager_index_path
  end

  def valid_params?
    params[:title] && !params[:title].empty?
  end

  def valid_params_submenu?
    params[:title] && !params[:title].empty? && params[:menu] && !params[:menu].empty?
  end

end
