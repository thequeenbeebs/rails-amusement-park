class AttractionsController < ApplicationController
    def index
        @attractions = Attraction.all
        @user = User.find_by(id: session[:user_id])
    end

    def new 
        @attraction = Attraction.new
    end

    def create
        @attraction = Attraction.create(attraction_params)
        redirect_to attraction_path(@attraction)
    end

    def show
        @attraction = Attraction.find(params[:id])
        @user = User.find(session[:user_id])
    end

    def edit
        @attraction = Attraction.find(params[:id])
    end

    def update
        @attraction = Attraction.find(params[:id])
        @attraction.update(attraction_params)
        redirect_to attraction_path(@attraction)
    end

    def ride
        @attraction = Attraction.find(params[:id])
        @user = User.find(session[:user_id])
        @ride = Ride.create(attraction_id: @attraction.id, user_id: @user.id)
        @ride.take_ride
        if @user.tickets < @attraction.tickets && @user.height < @attraction.min_height
            msg = "Sorry. You do not have enough tickets to ride the #{@attraction.name}. You are not tall enough to ride the #{@attraction.name}."
        elsif @user.tickets < @attraction.tickets
            msg = "Sorry. You do not have enough tickets to ride the #{@attraction.name}."
        elsif @user.height < @attraction.min_height
            msg = "Sorry. You are not tall enough to ride the #{@attraction.name}."
        else   
            msg = "Thanks for riding the #{@attraction.name}!"
        end
        flash.alert = msg
        redirect_to user_path(@user)
    end

    private

    def attraction_params
        params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
    end
end
