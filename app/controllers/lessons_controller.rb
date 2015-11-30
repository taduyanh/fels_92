class LessonsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_lesson_data, only: [:create, :update]

  def create
    lesson = Lesson.new @lesson_data
    if lesson.save
      redirect_to lesson
    else
      redirect_to categories_path
    end
  end

  def show
    @lesson = Lesson.find params[:id]
    @lesson_words =  @lesson.lesson_words
    render 'result' if @lesson.finished?
  end

  def update
    lesson = Lesson.find params[:id]
    @lesson_data[:finished] = true
    lesson.update @lesson_data
    redirect_to lesson
  end

  private 
  def lessons_param
    params.require(:lesson).permit :category_id, lesson_words_attributes: [:id, :answer_id]
  end

  def set_lesson_data
    @lesson_data = lessons_param
    @lesson_data[:user_id] = current_user.id
  end
end
