class Bike < ApplicationRecord
	belongs_to :listing, optional: true
	has_many :photos, dependent: :destroy

	validates :size, presence: true

	enum size: [:small, :medium, :large]

	def equipments
		equipments = Bike.where('id = ?', self.id).pluck_to_hash(:lights, :helmet, :fonts, :basket,
			:hasBackPedalBrake, :child_seat).first
		return equipments
	end

	def formatedEquipments
		formatedEquipemnts = Array.new
		self.equipments.keys.each do |key|
			if self.equipments[key]
				formatedEquipemnts.push(Bike.human_attribute_name(key).downcase)
			end
		end
		return formatedEquipemnts.compact.join(', ')
	end
end
