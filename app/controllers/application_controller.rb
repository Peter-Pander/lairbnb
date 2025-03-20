class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :skip_flash_messages

  def after_sign_in_path_for(resource)
    root_path # Redirects user to the homepage after signing in
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # Redirects user to the homepage after signing out
  end

  private

  def skip_flash_messages
    flash.delete(:notice) if flash[:notice] == "Signed in successfully." || flash[:notice] == "Signed out successfully."
    flash.delete(:alert) if flash[:alert].present?
  end
end
