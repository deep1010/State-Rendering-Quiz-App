class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      @questions = Question.all
    else
      redirect_to "/422"
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      @question = Question.new
    else
      redirect_to "/422"
    end
  end

  # GET /questions/1/edit
  def edit
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
    else
      redirect_to "/422"
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      ques=params[:question]
      if Subgenre.find_by(name: ques[:sname] , gname: ques[:gname])
        @question = Question.new(question_params)
        respond_to do |format|
          if @question.save
            format.html { redirect_to @question, notice: 'Question was successfully created.' }
            format.json { render :show, status: :created, location: @question }
          else
            format.html { render :new }
            format.json { render json: @question.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to "/questions/new", notice: "Please select appropriate Subgenre"
      end
    else
      redirect_to "/422"
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      respond_to do |format|
        if @question.update(question_params)
          format.html { redirect_to @question, notice: 'Question was successfully updated.' }
          format.json { render :show, status: :ok, location: @question }
        else
          format.html { render :edit }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to "/422"
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      @question.destroy
      respond_to do |format|
        format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to "/422"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :option1, :option2, :option3, :option4, :answer, :gname, :sname)
    end
end
