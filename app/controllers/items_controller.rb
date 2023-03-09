class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: 'Item successfully created'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item successfully updated'
    else
      render :edit, notice: 'Item not updated'
    end
  end

  def destroy
    if @item.destroy
      redirect_to items_path, notice: 'Item successfully deleted'
    else
      redirect_to items_path, notice: 'Item not deleted'
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
