class ManagerController < ApplicationController

  http_basic_authenticate_with :name => "manager", :password => "manager"
  layout 'manager'

  def index
    @menus = Submenus.where(menu: nil).order('position ASC').limit(1000).all
  end

  def news
    if request.post?
      if true#valid_params_submenu?
        b = News.new
        b.title = params[:title].html_safe[0,200]
        b.description = params[:description].html_safe[0,200]
        b.body = params[:body].html_safe
        b.cdate = params[:cdate].html_safe
        b.save
      end
    end
    @news = News.order('cdate DESC, id DESC').limit(1000).all
  end

  def deletenews
    id = params[:id]
    bug = News.find_by_id(id)
    bug.destroy if bug
    redirect_to manager_news_path
  end

  def addmenu
    if request.post?
      if valid_params_submenu?
        b = Submenus.new
        b.title = params[:title].html_safe[0,200]
        b.menu = params[:menu].html_safe
        b.save
        redirect_to manager_index_path
      end
    end
  end

  def additem
    if request.post?
      if valid_params_submenu?
        b = Items.new
        b.title = params[:title].html_safe[0,200]
        b.description = params[:description].html_safe[0,200]
        b.body = params[:body].html_safe
        b.menu = params[:menu].html_safe
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
          b.title = params[:title].html_safe[0,200]
          b.description = params[:description].html_safe[0,200]
          b.body = params[:body].html_safe
          b.menu = params[:menu].html_safe
          b.save
         end
        redirect_to manager_index_path
      end
    end
  end

  def updatenews
    if request.post?
      if valid_params_submenu?
        b = News.where(id: params[:id]).first
        if b
          b.title = params[:title].html_safe[0,200]
          b.description = params[:description].html_safe[0,200]
          b.body = params[:body].html_safe
          b.save
        end
        redirect_to manager_news_path
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
