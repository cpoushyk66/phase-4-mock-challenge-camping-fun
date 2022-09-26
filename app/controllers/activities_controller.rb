class ActivitiesController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :render_validations_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
        activities = Activity.all
        render json: activities, status: :ok
    end

    def show 
        activity = find_activity
        render json: activity, status: :ok
    end

    def create
        activity = Activity.create!(activity_params)
        render json: activity, status: :created
    end

    def update
        activity = find_activity
        activity.update!(activity_params)
        render json: activity, status: :accepted
    end

    def destroy
        activity = find_activity
        activity.destroy
        head :no_content
    end

    private

    def find_activity
        Activity.find(params[:id])
    end

    def activity_params
        params.permit(:name, :difficulty)
    end

    def render_validations_error
        render json: {errors: ["validations error"]}, status: :unprocessable_entity
    end

    def render_not_found
        render json: {error: "Activity not found"}, status: :not_found
    end
end
