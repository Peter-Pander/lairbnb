class UsersController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is signed in

  # Display the user's profile page
  def profile
    @user = current_user

    # Ensure the user is a landlord and has at least one flat
    @flat = @user.flats.first

    # Find the first message involving the user (either as sender or receiver)
    @message = Message.where(sender: @user).or(Message.where(receiver: @user)).first
  end

  def update_role
    @user = current_user

    if @user.update(user_params)
      redirect_to profile_path, notice: "Role updated successfully."
    else
      render :profile, alert: "There was an issue updating the role."
    end
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
    params.require(:user).permit(:role, :name, :email, :photo)  # Ensure :photo is permitted for file upload
  end
end
