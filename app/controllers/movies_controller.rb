class MoviesController < ApplicationController

  def index
    @movies = Movie.sorted_by_average_stars
    if params[:actor_search].present?
      @movies = @movies.where("actors @> ARRAY[?]::varchar[]", params[:actor_search])
    end
  end

end
