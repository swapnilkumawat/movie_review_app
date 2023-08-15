namespace :csv do
  desc "Import movies and reviews from CSV"
  task import: :environment do
    CsvImportWorkerJob.perform_async("public/movies.csv", 'movies')
    CsvImportWorkerJob.perform_async("public/reviews.csv", 'reviews')
  end
end
