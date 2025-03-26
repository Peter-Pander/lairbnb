class UsersController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is signed in

  # Display the user's profile page
  def profile
    @user = current_user

    # Ensure the user is a landlord and has at least one flat
    @flat = @user.flats.first

    # Get all messages received by the landlord
    @messages = Message.where(receiver_id: @user.id)

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

  def show
    @user = User.find(params[:id])
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
    params.require(:user).permit(
      :name,
      :email,
      :photo,
      :tavern_talk,
      :adventuring_profession,
      :dream_realm,
      :cursed_habit,
      :companion_creature,
      :age_of_origin,
      :trained_at,
      :unexpected_quirk,
      :useless_talent,
      :battle_song,
      :tongues_you_speak,
      :title_of_your_scroll,
      :enchanted_by,
      :sleeping_conditions,
      :resting_weapon,
      :travel_style,
      :innkeeping_philosophy
    )
  end
end
