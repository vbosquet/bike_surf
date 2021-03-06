class Photo < ApplicationRecord
  belongs_to :bike, optional: true

  has_attached_file :attachment, styles: { medium: "300x300#", thumb: "75x75#", mini: "30x30#" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\z/

end
