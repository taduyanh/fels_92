class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @categories = Category.all
  end
end
