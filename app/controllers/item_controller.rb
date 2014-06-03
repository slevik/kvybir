class ItemController < ApplicationController

  def index
    @news = News.order('cdate DESC, id DESC').limit(10).all
  end

  def show
    @news = News.order('cdate DESC, id DESC').limit(10).all
    @items = Items.where(:menu => params[:id]).order('position ASC').limit(1000).all
    @id = params[:id]
  end

  def info
    @item = Items.where(:id => params[:id]).first
    @id = @item.menu
  end

  def newsinfo
    @news = News.order('cdate DESC, id DESC').limit(10).all
    @item = News.where(:id => params[:id]).first
  end

end
