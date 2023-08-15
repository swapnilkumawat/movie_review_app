class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :year
      t.string :director
      t.string :actors, array: true, default: []
      t.string :filming_location
      t.string :country

      t.timestamps
    end
  end
end
