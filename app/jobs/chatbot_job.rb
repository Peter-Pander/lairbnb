# app/jobs/chatbot_job.rb
class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question)
    @question = question
    chatgpt_response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: questions_formatted_for_openai # to code as private method
      }
    )
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    question.update(ai_answer: new_content)
    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question", locals: { question: question })
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def questions_formatted_for_openai
    questions = @question.user.questions
    results = []
    system_text = "You are the owner of this website called lairbnb.
              lairbnb is designed for adventurers seeking a peaceful and comfortable place to rest.
              Your potential customers (adventurers) could be human, but also Orcs, Tauren, goblins, gnomes, elfes, bloodelves, nightelves etc.
              There are two different kinds of users. A tenant-user who wants to rent a lair and a landlord-user who wants to host his or her lair.
              You are a goblin. In your first message you say one of the following:
              'Talk to me' or 'I got what you need!' or 'Ah, potential customer.' or 'May I show you my wares?'
              or 'Welcome, friend!' or 'Yeah, what do you want?' or 'Wazzup?' or 'Heeey, how you doin'?'
              or 'Yo' or 'Can i lighten that coin purse up for ya?.'
              When you reply to the second question of the user you will not say one of the following:
              'Talk to me' or 'I got what you need!' or 'Ah, potential customer.' or 'May I show you my wares?'
              or 'Welcome, friend!' or 'Yeah, what do you want?' or 'Wazzup?' or 'Heeey, how you doin'?'
              or 'Yo' or 'Can i lighten that coin purse up for ya?.'
              You will then make conversation with the tenant-user about the website lairbnb.
              You want him to stay in one of the lairs hosted by your landlord-users.
              Here are the flats you should use to answer the user's questions:"
    # to nearest_flats code as private method
    nearest_flats.each do |flat|
      system_text += "FLAT #{flat.id}:
      name: #{flat.name}, description: #{flat.description}, price_per_night: #{flat.price_per_night}"
    end
    results << { role: "system", content: system_text }

    questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end
    return results
  end

  def nearest_flats
    # 1. Convert the question to a vector
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: @question.user_question
      }
    )
    question_embedding = response['data'][0]['embedding']

    # 2. Find the nearest neighbors to that vector
    return Flat.nearest_neighbors(
      :embedding, question_embedding,
      distance: "euclidean"
    ).first(3) # you may want to add .first(3) here to limit the number of results
    # Or you might not want to add that, you just have to try out
  end
end
