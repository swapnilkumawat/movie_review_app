class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :movie, null: false, foreign_key: true
      t.string :user_name
      t.integer :stars
      t.text :review_text

      t.timestamps
    end
  end
end
