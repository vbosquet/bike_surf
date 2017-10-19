class Bike < ApplicationRecord
	belongs_to :listing, optional: true

	has_attached_file :photo, styles: { medium: "276x180#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

	enum size: [:small, :medium, :large]
end
