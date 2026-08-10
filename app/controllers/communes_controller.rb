require "csv"

class CommunesController < ApplicationController
  rescue_from ActionController::UnknownFormat, with: -> { head :not_acceptable }

  def index
    @communes = Commune.all

    respond_to do |format|
      format.json { render json: @communes }
      format.csv { send_data Commune.to_csv, filename: "export_communes.csv", type: "text/csv" }
    end
  end

  def show
  end

  def create
  end

  def update
  end

end
