require "csv"

class CommunesController < ApplicationController
  before_action :set_commune, only: [:show, :update]
  rescue_from ActionController::UnknownFormat, with: -> { head :not_acceptable }
  rescue_from ActiveRecord::RecordNotFound, with: -> { head :not_found }
  rescue_from ActionController::ParameterMissing, with: -> { head :bad_request }

  def index
    @communes = Commune.all

    respond_to do |format|
      format.json { render json: @communes }
      format.csv { send_data Commune.to_csv, filename: "export_communes.csv", type: "text/csv" }
    end
  end

  def show
    render json: @commune
  end

  def create
    head :forbidden 
  end

  def update
    @commune.update!(commune_model_params)
    head :no_content
  end

  private

  def commune_model_params
    params.require(:commune).permit(:name)
  end

  def set_commune
    @commune = Commune.find_by!(code_insee: params[:id])
  end
end
