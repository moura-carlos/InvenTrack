class ItemsController < ApplicationController
  before_action :require_signin

  before_action :find_item, only: [:show, :edit, :update, :destroy]
  after_action :send_email, only: [:create, :update]

  def index
    # @user = current_user
    # @items = @user.items
    @user = current_user
    @q = params[:q]
    if @q.present? && @q[:name_cont].present?
      search_query = @q[:name_cont]
      @searched_items = @user.is_admin? ? Item.where("title LIKE ?", "%#{@q[:name_cont]}%") : @user.items.where("title LIKE ?", "%#{search_query}%")
      if @searched_items.empty?
        flash.now[:alert] = "No items found for '#{search_query}'"
      end
    else
      @items = @user.items
      if @user.is_admin?
        @all_items = Item.all
      end
    end
  end

  def new
    @user = current_user
    @item = @user.items.new
  end

  def create
    @user = current_user
    @item = @user.items.new(item_params)
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
    params.require(:item).permit(:title, :description, :quantity, :price, :main_image, category_ids: [])
  end

  def find_item
    @user = current_user
    if @user.is_admin?
      @item = Item.find(params[:id])
    else
      @item = @user.items.find(params[:id])
    end
  end

  def send_email
    ItemMailer.stock(@item, current_user).deliver_now
  end
end
