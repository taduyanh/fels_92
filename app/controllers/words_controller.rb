
class WordsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @categories = Category.all
    filter = ['learn', 'not_learn']
    if filter.include? params[:filter]
      @words = Word.by_category(params[:category_id])
                 .send(params[:filter], current_user)
    else
      @words = Word.by_category(params[:category_id])
    end
    @words = @words.paginate(page: params[:page])
  end

end
