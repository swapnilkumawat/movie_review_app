class CsvImportWorkerJob
  include Sidekiq::Job

  def perform(file_path, table)
    ActiveRecord::Base.connection_pool.with_connection do
      import_movies(file_path) if table == 'movies'
      import_reviews(file_path) if table == 'reviews'
    end
  end

  private

  def import_movies(file_path)
    SmarterCSV.process(file_path, key_mapping: {movie: :title, description: :description, year: :year, director: :director, actor: :actor, filming_location: :filming_location, country: :country}) do |chunk|
      chunk.each do |row|
        movie = Movie.find_or_initialize_by(title: row[:title])
        movie.description = row[:description]
        movie.year = row[:year].to_i
        movie.director = row[:director]
        next if movie.actors.include?(row[:actor])
        movie.actors << row[:actor]
        movie.filming_location = row[:filming_location]
        movie.country = row[:country]

        movie.save
      end
    end
  end

  def import_reviews(file_path)
    SmarterCSV.process(file_path, key_mapping: {movie: :movie_title, user: :user_name, stars: :stars, review: :review_text}) do |chunk|
      reviews = []
      chunk.each do |row|
        movie = Movie.find_by(title: row[:movie_title])
        next unless movie

        reviews << Review.new(movie: movie, user_name: row[:user_name], stars: row[:stars], review_text: row[:review_text])
      end
      Review.import(reviews)
    end
  end

end
