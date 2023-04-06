class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_response
    def index
        apartments = Apartment.all
        render json: apartments
    end
    def create
        apt = Apartment.create(apartment_params)
        render json: apt, status: :created
    end

    def show
        apt = find_apartment
        render json: apt
    end

    def update
        apt = find_apartment
        apt.update(apartment_params)
        render json: apt, status: :accepted
    end
    def destroy
        apt = find_apartment
        apt.destroy
        head :no_content, status: :gone
    end

    private
    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find(params[:id])
    end

    def render_not_found_response
        render json: {error: 'error not found'}, status: :not_found
    end
    
    def invalid_record_response
        render json: {error: 'invalid params'}, status: :unprocessable_entity
    end

end
