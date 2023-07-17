class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update destroy edit hide]
  before_action :set_question_for_current_user, only: %i[update destroy edit hide]

  def create
    @question = Question.create(create_question_params)
    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user.nickname), notice: 'Новый вопрос создан!'
    else
      redirect_to root_path, notice: 'Вопрос не отправлен'
    end
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user.nickname), notice: 'Вопрос удален!'
  end

  def edit
  end

  def hide
    @question.update(hidden: true)

    redirect_to questions_path, notice: 'Вопрос скрыт!'
  end

  def index
    @questions = Question.order(created_at: :desc).last(10)
    @users = User.order(created_at: :desc).last(10)
  end

  def new
    @user = User.find_by!(nickname: params[:nickname])
    @question = Question.new(user: @user)
  end

  def show
    @question = Question.find(params[:id])
  end

  def update
    @question.update(update_question_params)

    redirect_to user_path(@question.user.nickname), notice: 'Вопрос изменен!'
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def create_question_params
    params.require(:question).permit(:body, :user_id)
  end

  def update_question_params
    params.require(:question).permit(:body, :answer)
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end

end
