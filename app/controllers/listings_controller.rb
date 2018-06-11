class ListingsController < ApplicationController

	def new
		@listing = Listing.new
	end

	def index
		@listing = Listing.all
	end

	def create
		@listing = current_user.listings.new(new_listings_params)
		if @listing.save
			redirect_to '/listings'
		end
	end
	
	def new_listings_params
		params.require(:listing).permit(:name, :place_type, :property_type, :room_number,:bed_number, :guest_number,:country,:state, :city, :zipcode, :description, :address, :price, :description)
	end

end