class AddSeatsCapacityToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :seats_capacity, :integer
  end
end
