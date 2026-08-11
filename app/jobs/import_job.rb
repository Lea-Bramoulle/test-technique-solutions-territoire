require "csv"

class ImportJob < ApplicationJob
  queue_as :default

  FORMS = { "CA" => "ca", "CU" => "cu", "CC" => "cc", "METRO" => "met" }.freeze

  def perform(csv)
    CSV.foreach(csv, headers: true, col_sep: ";", encoding: "ISO-8859-1:UTF-8") do |row|
      intercommunality = Intercommunality.find_or_create_by!(siren: row["siren_epci"]) do |intercommunality|
        intercommunality.name = row["nom_complet"]
        intercommunality.form = FORMS.fetch(row["form_epci"])
        intercommunality.siren = row["siren_epci"]
      end

      Commune.find_or_create_by!(code_insee: row["insee"]) do |c|
        c.name = row["nom_com"]
        c.population = row["pop_total"].to_i
        c.intercommunality = intercommunality
      end
    end
  end
end
