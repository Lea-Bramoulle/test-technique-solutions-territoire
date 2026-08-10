require "csv"

class CommunesController < ApplicationController
  rescue_from ActionController::UnknownFormat, with: -> { head :not_acceptable }
  rescue_from ActiveRecord::RecordNotFound, with: -> { head :not_found }

  def index
    @communes = Commune.all

    respond_to do |format|
      format.json { render json: @communes }
      format.csv { send_data Commune.to_csv, filename: "export_communes.csv", type: "text/csv" }
    end
  end

  def show
    @commune = Commune.find_by!(code_insee: params[:id])
    render json: @commune
  end

  def create
    head :forbidden 
  end

  def update
  end

end
