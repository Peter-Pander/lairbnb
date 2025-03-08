# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is signed in

  def profile
    @user = current_user  # This will give you the current logged-in user
  end
end
