class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :is_admin, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    if current_user && current_user.is_admin?
      @items = @category.items
    else
      @items = @category.user_items(current_user)
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, status: :see_other, notice: "Category was successfully created."
    else
      flash.now[:alert] = "Oops! Category could not be created."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, status: :see_other, notice: "Category was successfully updated."
    else
      flash.now[:alert] = "Oops! Category could not be updated."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, status: :see_other, notice: "Category was successfully deleted."
    else
      flash[:alert] = "Oops! Category could not be deleted."
      redirect_to categories_path
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def is_admin
    redirect_to categories_path, notice: "You are not authorized to do that!" unless current_user.is_admin?
  end
end
