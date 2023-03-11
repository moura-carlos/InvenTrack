class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  after_action :send_email, only: [:create, :update]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, status: :see_other, notice: 'Item successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to @item, status: :see_other, notice: 'Item successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      redirect_to items_url, status: :see_other, notice: 'Item successfully deleted!'
    else
      render :show, notice: 'Something went wrong! Please, try again.'
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :quantity, :price, :main_image)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def send_email
    ItemMailer.stock(@item, current_user).deliver_now
  end
end
