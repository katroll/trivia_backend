class CategoriesController < ApplicationController
  def index
    ordered_categories = Category.order(:name)
    render json: ordered_categories, status: :ok
  end
end