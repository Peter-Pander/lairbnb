require "open-uri"

# Clear existing data
puts "Clearing existing data..."
Flat.destroy_all
User.destroy_all

# Seeding Users
puts "Seeding users..."

landlord = User.create!(
  email: 'landlord@example.com',
  password: 'sandwich'
)

tenant = User.create!(
  email: 'tenant@example.com',
  password: 'sandwich'
)

puts "Users seeded successfully!"

# Seeding Lairs (Flats)
puts "Seeding lairs..."

lairs = [
  {
    name: "Dragon's Den",
    description: "A cozy lair carved into the side of a mountain, perfect for a long rest after a flight through the skies.",
    address: "123 Dragonridge, Firepeak Mountain",
    price_per_night: 75,
    amenities: "Wi-Fi, Dragon's Roar Fireplace, Treasure Chest, Mountain View",
    image_url: "https://res.cloudinary.com/dadymzua9/image/upload/v1/dragonsden237_krf9v1.jpg"
  },
  {
    name: "Elven Treehouse",
    description: "Nestled high in the trees, this serene hideaway offers views of the enchanted forest and access to a secret elven library.",
    address: "456 Forest Glade, Eldertree",
    price_per_night: 120,
    amenities: "Wi-Fi, Healing Waters, Elven Magic, Forest View",
    image_url: "https://res.cloudinary.com/dadymzua9/image/upload/v1/Elven_Treehouse_kgs03p.jpg"
  },
  {
    name: "Wizard's Tower",
    description: "A tall tower full of mystery and ancient tomes, with a view of the nearby magical ley lines.",
    address: "789 Tower Lane, Magician's Peak",
    price_per_night: 95,
    amenities: "Wi-Fi, Potion Brewing Kit, Magical Artifacts, Stargazing Platform",
    image_url: "https://res.cloudinary.com/dadymzua9/image/upload/v1/wizardstower3234_eupz68.jpg"
  },
  {
    name: "Goblin Hideout",
    description: "A rustic, underground hideout hidden in the heart of the hills, perfect for adventurous goblins looking for a secret escape.",
    address: "1010 Goblin Hollow, Shadow Hill",
    price_per_night: 250,
    amenities: "Wi-Fi, Goblin's Forge, Hidden Treasures, Secret Tunnel",
    image_url: "https://res.cloudinary.com/dadymzua9/image/upload/v1/Goblin_Hideout2_oh5myx.jpg"
  },
  {
    name: "Dwarven Stronghold",
    description: "A sturdy underground fortress built into the mountains, offering warmth, safety, and endless halls filled with dwarven craftsmanship.",
    address: "2222 Granite Keep, Irondeep Mountains",
    price_per_night: 110,
    amenities: "Wi-Fi, Smithy, Mead Hall, Gemstone Vault",
    image_url: "https://res.cloudinary.com/dadymzua9/image/upload/v1/Dwarven_Stronghold_wxz6ay.jpg"
  }
]

# Create lairs and attach images
lairs.each do |lair_data|
  lair = Flat.create!(
    name: lair_data[:name],
    description: lair_data[:description],
    address: lair_data[:address],
    price_per_night: lair_data[:price_per_night],
    amenities: lair_data[:amenities],
    user: landlord
  )

  # Attach image from Cloudinary
  file = URI.open(lair_data[:image_url])
  lair.photo.attach(io: file, filename: "#{lair.name.parameterize}.jpg", content_type: "image/jpeg")

  puts "Created lair: #{lair.name} with image #{lair_data[:image_url]}"
end

puts "Lairs seeded successfully!"
