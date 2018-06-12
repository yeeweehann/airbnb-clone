class UsersController < ApplicationController
	before_action :require_login

	def index
	end

	# def become_host
	# 	user = User.find(params[:id])
	# 	user.host!
	# 	redirect_back
	# end

end
