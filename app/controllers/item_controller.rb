class ItemController < ApplicationController

  def index
    @news = News.order('cdate DESC, id DESC').limit(10).all
  end

  def show
    @news = News.order('cdate DESC, id DESC').limit(10).all
    @items = Items.where(:menu => params[:id]).order('position ASC').limit(1000).all
    @id = params[:id]
    if @items.size == 1
      redirect_to "/item/info/#{@items.first.id}"
      return
    end
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
