class Restaurant < ApplicationRecord
  has_and_belongs_to_many :culinaries, dependent: :destroy
  has_many :reservations

  scope :by_culinary, ->(culinary_id) { joins(:culinaries).where(culinaries: { id: culinary_id }) }

  scope :with_seats_available, ->(date, seats) do
    left_outer_joins(:reservations)
      .select('restaurants.*, COALESCE(SUM(reservations.seats), 0) AS seats_booked')
      .where('reservations.event_time between :sdate and :edate OR seats_capacity > 0', { sdate: date.beginning_of_day, edate: date.end_of_day })
      .having('seats_booked <= (restaurants.seats_capacity - :seats_need)', { seats_need: seats })
      .group('restaurants.id')
  end
end
