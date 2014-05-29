class ManagerController < ApplicationController

  http_basic_authenticate_with :name => "manager", :password => "manager"

  def index
    @menus = Submenus.where(menu: nil).order('position ASC').limit(1000).all
  end

  def addmenu
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

  def additem
    if request.post?
      if valid_params_submenu?
        b = Items.new
        b.title = params[:title]
        b.description = params[:description]
        b.body = params[:body]
        b.menu = params[:menu]
        b.save
        redirect_to manager_index_path
      end
    end
  end

  def updateitem
    if request.post?
      if valid_params_submenu?
        b = Items.where(id: params[:id]).first
         if b
          b.title = params[:title]
          b.description = params[:description]
          b.body = params[:body]
          b.menu = params[:menu]
          b.save
         end
        redirect_to manager_index_path
      end
    end
  end

  def deleteitem
    id = params[:id]
    bug = Items.find_by_id(id)
    bug.destroy if bug
    redirect_to manager_index_path
  end

  def deletemenu
    id = params[:menu]
    bug = Submenus.find_by_id(id)
    bug.destroy if bug
    redirect_to manager_index_path
  end

  def valid_params_submenu?
    params[:title] && !params[:title].empty?# && params[:menu] && !params[:menu].empty?
  end

end
