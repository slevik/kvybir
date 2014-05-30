class ItemController < ApplicationController

  def index
  end

  def show
    @items = Items.where(:menu => params[:id]).order('position ASC').limit(1000).all
    @id = params[:id]
  end

  def info
    @item = Items.where(:id => params[:id]).first
    @id = @item.menu
  end

end
