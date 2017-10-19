class Availability < ApplicationRecord
	belongs_to :listing

	enum advance_notice: ["Le jour même", "Au moins 1 jour", "Au moins 2 jours", "Au moins 3 jours", "Au moins 7 jours"]
end
