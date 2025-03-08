class UsersController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is signed in

  # Display the user's profile page
  def profile
    @user = current_user  # This will give you the current logged-in user
  end

  # Display the edit profile form
  def edit
    @user = current_user
  end

  # Update the user's profile with new data
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      render :profile
    end
  end

  private

  # Strong parameters to allow specific attributes
  def user_params
    params.require(:user).permit(:name, :email, :photo)  # Ensure :photo is permitted for file upload
  end
end
