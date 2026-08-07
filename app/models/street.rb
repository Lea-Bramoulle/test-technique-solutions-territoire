class Street < ApplicationRecord
  validates :title, 
            presence: true
  validates :from, 
            numericality: { only_integer: true, greater_than: 0 }, 
            allow_nil: true
  validates :to,
            numericality: { only_integer: true, greater_than: 0 }, 
            allow_nil: true
  validate :to_greater_than_from
  has_many :street_locations, dependent: :destroy
  has_many :communes, through: :street_locations

  private

  def to_greater_than_from
    return unless from && to
    
    errors.add(:to, ":to must be greater than :from") if to <= from
  end
end
