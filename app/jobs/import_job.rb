require "csv"

class ImportJob < ApplicationJob
  queue_as :default

  FORMS = { "CA" => "ca", "CU" => "cu", "CC" => "cc", "METRO" => "met" }.freeze

  CSV_HEADERS = {
    siren: "siren_epci",
    epci_name: "nom_complet",
    epci_form: "form_epci",
    insee: "insee",
    commune_name: "nom_com",
    population: "pop_total"
  }.freeze
  
  def perform(csv)
    CSV.foreach(csv, headers: true, col_sep: ";", encoding: "ISO-8859-1:UTF-8") do |row|
      intercommunality = Intercommunality.find_or_create_by!(siren: row[CSV_HEADERS[:siren]]) do |intercommunality|
        intercommunality.name = row[CSV_HEADERS[:epci_name]]
        intercommunality.form = FORMS.fetch(row[CSV_HEADERS[:epci_form]])
        intercommunality.siren = row[CSV_HEADERS[:siren]]
      end

      Commune.find_or_create_by!(code_insee: row[CSV_HEADERS[:insee]]) do |c|
        c.name = row[CSV_HEADERS[:commune_name]]
        c.population = row[CSV_HEADERS[:population]].to_i
        c.intercommunality = intercommunality
      end
    end
  end
end
