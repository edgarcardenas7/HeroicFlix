class GenresController < ApplicationController
    before_action :require_admin, except: [:index, :show]
  
    def index
      @genres = Genre.all
    end
  
    def show
      @genre = Genre.find(params[:id])
      @movies = @genre.movies
    end
  
    def new
      @genre = Genre.new
    end
  
    def create
      @genre = Genre.new(genre_params)
      if @genre.save
        redirect_to @genre, notice: 'Genre successfully created!'
      else
        render :new
      end
    end
  
    def edit
      @genre = Genre.find(params[:id])
    end
  
    def update
      @genre = Genre.find(params[:id])
      if @genre.update(genre_params)
        redirect_to @genre, notice: 'Genre successfully updated!'
      else
        render :edit
      end
    end
  
    def destroy
      @genre = Genre.find(params[:id])
      @genre.destroy
      redirect_to genres_url, notice: 'Genre successfully deleted!'
    end
  
    private
  
    def genre_params
      params.require(:genre).permit(:name)
    end
  
    def require_admin
      redirect_to(root_path, alert: 'Access denied') unless current_user&.admin?
    end
  end
  