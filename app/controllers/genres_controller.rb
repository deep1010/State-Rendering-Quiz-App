class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]

  # GET /genres
  # GET /genres.json
  def index
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      @genres = Genre.all
    else
      redirect_to "422"
    end
  end

  # GET /genres/1
  # GET /genres/1.json
  def show
  end

  # GET /genres/new
  def new
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      @genre = Genre.new
    else
      redirect_to "/422"
    end
  end

  # GET /genres/1/edit
  def edit
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
    else
      redirect_to "/422"
    end
  end

  # POST /genres
  # POST /genres.json
  def create
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      @genre = Genre.new(genre_params)
      respond_to do |format|
        if @genre.save
          format.html { redirect_to @genre, notice: 'Genre was successfully created.' }
          format.json { render :show, status: :created, location: @genre }
        else
          format.html { render :new }
          format.json { render json: @genre.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to "/422"
    end
  end

  # PATCH/PUT /genres/1
  # PATCH/PUT /genres/1.json
  def update
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      respond_to do |format|
        if @genre.update(genre_params)
          format.html { redirect_to @genre, notice: 'Genre was successfully updated.' }
          format.json { render :show, status: :ok, location: @genre }
        else
          format.html { render :edit }
          format.json { render json: @genre.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to "/422"
    end
  end

  # DELETE /genres/1
  # DELETE /genres/1.json
  def destroy
    if session[:user_id] and User.find_by(id: session[:user_id]).name == "admin"
      g=Genre.find(params[:id])
      if @a=Attempt.where(:sname => g.name)
        @a.destroy_all
      end
      Subgenre.where(:gname => g.name).destroy_all
      Question.where(:gname => g.name).destroy_all
      @genre.destroy
      respond_to do |format|
        format.html { redirect_to genres_url, notice: 'Genre was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to "/422"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genre_params
      params.require(:genre).permit(:name)
    end
end
