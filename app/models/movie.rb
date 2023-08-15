class Movie < ApplicationRecord

  scope :sorted_by_average_stars, -> {
    joins("LEFT JOIN reviews ON movies.id = reviews.movie_id")
      .group("movies.id")
      .order("AVG(reviews.stars) DESC NULLS LAST")
  }

end
