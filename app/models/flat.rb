class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :name, :description, :price_per_night, :address, presence: true
  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_neighbors :embedding
  after_create :set_embedding

  private

  def set_embedding
    client = OpenAI::Client.new
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: "Flat: #{name}. Description: #{description}, Price per night: #{price_per_night}"
      }
    )
    embedding = response['data'][0]['embedding']
    update(embedding: embedding)
  end
end
