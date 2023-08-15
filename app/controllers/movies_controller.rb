class MoviesController < ApplicationController

  def index
    @movies = Movie.all
    if params[:actor_search].present?
      @movies = @movies.where("actors @> ARRAY[?]::varchar[]", params[:actor_search])
    end
  end

end
