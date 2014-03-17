class ItemsController < ApplicationController

  before_filter :find_item, only: [:show, :edit, :update, :destroy, :upvote]
  #  before_filter :check_if_admin, only: [:edit, :update, :destroy, :create, :new]

  def index
    @items = Item
    @items = @items.where("price >= ?", params[:price_from])  if params[:price_from]
    @items = @items.where("created_at >=?", 1.day.ago)        if params[:today]
    @items = @items.where("votes_count >= ?", params[:votes_from])  if params[:votes_from]
    @items = @items.order("votes_count DESC", "price")
  end
  
  def expensive
    @items = Item.where("price > 1000")
    render "index"
  end
  
  def show
    unless @item 
      render text: "Page not here", status: 404
    end
  end
  
  def new
    @item = Item.new
  end
  
  def edit
  end
  
  def create
    @item = Item.create(item_params)
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render "new"
    end
  end

  def update
    @item.update_attributes(item_params)
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render "edit"
    end
  end
  
  def destroy
    @item.destroy
    redirect_to action: "index"
  end  
  
  def upvote
    @item.increment!(:votes_count)
    redirect_to action: "index"
  end
  
  private
  
    def item_params
      params.require(:item).permit(:name, :description, :price, :weight, :real, :image)
    end
    
    def find_item
      @item = Item.where(id: params[:id]).first
      render_404 unless @item
    end

end
