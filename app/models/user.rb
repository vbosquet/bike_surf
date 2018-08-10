class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :firstname, :lastname, presence: true

  has_many :listings, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "75x75#", mini: "30x30#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def full_name
    [self.firstname, self.lastname].compact.join(' ')
  end

end
