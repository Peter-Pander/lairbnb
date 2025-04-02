# app/jobs/chatbot_job.rb
class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question)
    @question = question
    chatgpt_response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: questions_formatted_for_openai
      }
    )
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    question.update(ai_answer: new_content)
    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question",
      locals: { question: question }
    )
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def questions_formatted_for_openai
    greetings = [
      "I got what you need!",
      "Ah, potential customer.",
      "Welcome, friend!"
    ]
    greeting = greetings.sample

    # Determine the conversation count based on the user's existing questions.
    conversation_count = @question.user.questions.count

    greeting_instruction = if conversation_count == 1
                            "In your first message, say one of the following: #{greeting}"
                          else
                            "Do not include any greeting; continue the conversation naturally."
                          end

    system_text = <<~SYSTEM
      You are the owner of this website called lairbnb.
      lairbnb is designed for adventurers seeking a peaceful and comfortable place to rest.
      Your potential customers (adventurers) could be human, but also Orcs, Tauren, goblins, gnomes, elfes, bloodelves, nightelves, etc.
      There are two different kinds of users: a tenant-user who wants to rent a lair and a landlord-user who wants to host his or her lair.
      You are a goblin. #{greeting_instruction}
      Then, engage in conversation with the tenant-user about lairbnb to encourage them to rent one of the lairs.
      Here are the flats you should refer to when answering the user's questions:
    SYSTEM

    nearest_flats.each do |flat|
      system_text += "FLAT #{flat.id}: name: #{flat.name}, description: #{flat.description}, price_per_night: #{flat.price_per_night}\n"
    end

    results = [{ role: "system", content: system_text }]

    # Append conversation history
    @question.user.questions.each do |q|
      results << { role: "user", content: q.user_question }
      results << { role: "assistant", content: q.ai_answer || "" }
    end

    results
  end

  def nearest_flats
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: @question.user_question
      }
    )
    question_embedding = response['data'][0]['embedding']

    Flat.nearest_neighbors(
      :embedding, question_embedding,
      distance: "euclidean"
    ).first(3)
  end
end
