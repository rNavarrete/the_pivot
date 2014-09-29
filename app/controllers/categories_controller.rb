class CategoriesController < ApplicationController
  def index
    @category = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.create(category_params)
  end

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
