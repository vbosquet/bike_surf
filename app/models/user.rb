class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :firstname, :lastname, presence: true

  has_many :listings, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :messages, dependent: :destroy

  def full_name
    [self.firstname, self.lastname].compact.join(' ')
  end

end
