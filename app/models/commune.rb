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

  def self.search(query)
    return all if query.blank?
    where("lower(name) LIKE ?", "%#{sanitize_sql_like(query.downcase)}%")
  end

  def self.to_csv
    CSV.generate(col_sep: ";") do |csv|
      csv << %w[code_insee name]
      all.each do |commune|
        csv << [commune.code_insee, commune.name]
      end
    end
  end
end

