class ListingsController < ApplicationController

	before_action :require_superadmin, only: [:verified]
	before_action :require_moderator, only: [:create, :new]
	before_action :require_customer, only: []

	def unverified
		@listing_count = Listing.where(verified: false).count
		@listings = Listing.page(params[:page]).per(15).where(verified: false)
	end 

	def verified
		@listing = Listing.find(params[:id])
		@listing.update(verified: 0)
		redirect_to "/listings"
	end

	def new
		@listing = Listing.new
	end

	def index
		@listing = Listing.all.order(:name).page(params[:page])
	end

	def create
		@listing = current_user.listings.new(new_listings_params)
		if @listing.save
			redirect_to '/listings'
		end
	end

	def show
		@listing = Listing.find(params[:id])
	end
	
	def new_listings_params
		params.require(:listing).permit(:name, :place_type, :property_type, :room_number,:bed_number, :guest_number,:country,:state, :city, :zipcode, :description, :address, :price, :description)
	end

	private
	
	def require_superadmin
		unless current_user == Listing.find(params[:id]).user || current_user.superadmin?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
        return redirect_to "/listings", notice: "Sorry. You do not have the permission to verify a property."
      	end
	end

	def require_moderator
	 	unless current_user == Listing.find(params[:id]).user || current_user.moderator?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
        return redirect_to "/listings", notice: "Sorry. You do not have the permission to verify a property."
	 	end
	end

	def require_customer
	 	unless current_user == Listing.find(params[:id]).user || current_user.customer?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
        return redirect_to "/sign_in", notice: "Please sign in before performing pervious action."
	 	end
	end
end