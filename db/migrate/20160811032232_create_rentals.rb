class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.references :book
      t.references :user
      t.timestamp :rental_date

      t.timestamps
    end
  end
end
