class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_flat
  before_action :set_landlord

  def index
    @flat = Flat.find(params[:flat_id])
    @messages = @flat.messages
    @message = Message.new  # Initialize a new empty message for the form
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

    # Ensure both tenant's and landlord's messages are included
    @messages = Message.where(sender_id: current_user.id, receiver_id: @landlord.id)
                      .or(Message.where(sender_id: @landlord.id, receiver_id: current_user.id))
                      .order(created_at: :asc)

    @message = Message.new  # Initialize a new message for the form
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.flat = Flat.find(params[:flat_id])

    # Fetch previous messages
    previous_messages = Message.where(flat: @message.flat)
                              .where(sender: @landlord).or(Message.where(receiver: @landlord))
                              .order(:created_at)

    if current_user == @landlord
      if previous_messages.any?
        @message.receiver = previous_messages.last.sender
      else
        raise "No previous messages found. Unable to determine recipient."
      end
    else
      @message.receiver = @landlord
    end

    if @message.save
      if current_user.role == "tenant"
        redirect_to new_flat_message_path(@message.flat)
      else
        redirect_to flat_messages_path(@message.flat)
      end
    else
      render :new, status: :unprocessable_entity
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
