class Intercommunality < ApplicationRecord
    validates :name, 
              presence: true
    validates :siren,
              presence: true, 
              uniqueness: { case_sensitive: false }, length: { is: 9 },
              format: { with: /\A[a-zA-Z0-9]{9}\z/, message: ":siren should contain 9 digits and any spaces" }
    validates :form, inclusion: { in: %w[ca cu cc met] }
    validates :slug, presence: true

    has_many :communes

    before_validation :generate_slug

    private

    def generate_slug
        if !slug.present? 
          self.slug = name.parameterize 
        end
    end
end
