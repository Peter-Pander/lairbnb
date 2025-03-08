class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_flat
  before_action :set_landlord

  def index
    @flat = Flat.find(params[:flat_id])
    @messages = @flat.messages
  end

  def show
    @landlord = @flat.user  # Assuming the landlord is the user associated with the flat
    @messages = @flat.messages.where(
      sender: [current_user, @landlord],   # Sender is either current_user or landlord
      receiver: [current_user, @landlord]  # Receiver is either current_user or landlord
    ).order(:created_at)

    @message = Message.new  # For the form to send messages
  end

  def new
    @flat = Flat.find(params[:flat_id])  # Find the flat
    @landlord = @flat.user               # Get the landlord
    @messages = Message.where(sender_id: current_user.id, receiver_id: @landlord.id)
    .or(Message.where(sender_id: @landlord.id, receiver_id: current_user.id))
    .order(created_at: :asc) # Get chat history

    @message = Message.new  # Initialize a new message for the form
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

  def set_flat
    @flat = Flat.find(params[:flat_id])  # Find the flat by flat_id
  end

  def set_landlord
    @landlord = @flat.user  # Assuming the landlord is the user who created the flat
  end
end
