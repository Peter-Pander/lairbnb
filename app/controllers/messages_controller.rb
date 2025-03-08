class MessagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @flat = Flat.find(params[:flat_id])  # Find the flat
    @messages = Message.where(
      flat: @flat,
      sender: [current_user, @flat.user], # Either current_user or landlord
      receiver: [current_user, @flat.user] # Either current_user or landlord
    ).order(:created_at)

    @message = Message.new  # For the form to send messages
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.flat = Flat.find(params[:flat_id])
    @message.receiver = @message.flat.user  # Assuming the landlord owns the flat

    if @message.save
      redirect_to flat_messages_path(@message.flat) # Redirect to the chat
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
