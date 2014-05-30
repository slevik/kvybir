class ItemController < ApplicationController

  def index
  end

  def show
    @items = Items.where(:menu => params[:id]).order('position ASC').limit(1000).all
  end

end
