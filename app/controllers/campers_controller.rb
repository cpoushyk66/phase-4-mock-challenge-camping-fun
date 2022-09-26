class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_validations_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    def index
        campers = Camper.all
        render json: campers, status: :ok
    end

    def show
        camper = find_camper
        render json: camper, serializer: CamperActivitySerializer, staus: :ok
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    def update
        camper = find_camper
        camper.update!(camper_params)
        render json: camper, status: :accepted
    end

    def destroy
        camper = find_camper
        camper.destroy
        head :no_content
    end

    private

    def find_camper
        Camper.find(params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def render_validations_error
        render json: {errors: ["validations errors"]}, status: :unprocessable_entity
    end

    def render_not_found
        render json: {error: "Camper not found"}, status: :not_found
    end
end
