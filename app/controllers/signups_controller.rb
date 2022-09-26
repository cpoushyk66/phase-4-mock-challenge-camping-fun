class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_validations_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
        signups = Signup.all
        render json: signups, status: :ok
    end

    def show
        signup = find_signup
        render json: signup, status: :ok
    end

    def create
        signup = Signup.create!(signup_params)
        render json: signup.activity, serializer: ActivitySerializer, status: :created
    end

    def update
        signup = find_signup
        signup.update!(signup_params)
        render json: signup, status: :accepted
    end

    def destroy
        signup = find_signup
        signup.destroy
        head :no_content
    end

    private

    def find_signup
        Signup.find(params[:id])
    end

    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def render_validations_error
        render json: {errors: ["validation errors"]}, status: :unprocessable_entity
    end

    def render_not_found
        render json: {error: "signup not found"}, status: :not_found
    end
end
