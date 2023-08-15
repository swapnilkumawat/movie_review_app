class MoviesController < ApplicationController

  def index
    @movies = Movie.sorted_by_average_stars

    if params[:actor_search].present?
      @movies = @movies.where("actors @> ARRAY[?]::varchar[]", params[:actor_search])
    end

    @movies = @movies.paginate(page: params[:page], per_page: 10)
  end

end
