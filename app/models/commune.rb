class Commune < ApplicationRecord
  validates :name, presence: true
  validates :code_insee, presence: true, uniqueness: true, length: { is: 5 },
            format: { with: /\A[0-9AB]{5}\z/i, message: ":code_insee should contain 5 digits or letters for french cities" }
  belongs_to :intercommunality, required: false
  has_many :street_locations, dependent: :destroy
  has_many :streets, through: :street_locations

  def self.to_hash
    pluck(:code_insee, :name).to_h
  end
end
