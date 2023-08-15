class AddIndexToActorsInMovies < ActiveRecord::Migration[7.0]
  def change
    add_index :movies, :actors, using: 'gin'
  end
end
