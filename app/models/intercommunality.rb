class Intercommunality < ApplicationRecord
    validates :name, 
              presence: true
    validates :siren,
              presence: true, 
              uniqueness: { case_sensitive: false }, length: { is: 9 },
              format: { with: /\A\d{9}\z/, message: ":siren should contain 9 digits and any spaces" }
    validates :form, inclusion: { in: %w[ca cu cc met] }
    validates :slug, presence: true

    has_many :communes

    before_validation :generate_slug


    def communes_hash
      communes.pluck(:code_insee, :name).to_h
    end

    private

    def generate_slug
        return if name.blank?
        self.slug = name.parameterize if slug.blank?
    end 
end
