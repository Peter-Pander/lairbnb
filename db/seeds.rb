# Clear existing data
puts "Clearing existing data..."
Flat.destroy_all
User.destroy_all

# Seeding Users
puts "Seeding users..."

# Create landlord user
landlord = User.create!(
  email: 'landlord@example.com',
  password: 'sandwich',
  password_confirmation: 'sandwich'
)

# Create tenant user
tenant = User.create!(
  email: 'tenant@example.com',
  password: 'sandwich',
  password_confirmation: 'sandwich'
)

puts "Users seeded successfully!"

# Seeding Lairs (Flats)
puts "Seeding lairs..."

# Lairs data as an array of hashes
lairs = [
  {
    name: "Dragon's Den",
    description: "A cozy lair carved into the side of a mountain, perfect for a long rest after a flight through the skies.",
    address: "123 Dragonridge, Firepeak Mountain",
    price_per_night: 75,
    amenities: "Wi-Fi, Dragon's Roar Fireplace, Treasure Chest, Mountain View",
    user_id: landlord.id
  },
  {
    name: "Elven Treehouse",
    description: "Nestled high in the trees, this serene hideaway offers views of the enchanted forest and access to a secret elven library.",
    address: "456 Forest Glade, Eldertree",
    price_per_night: 120,
    amenities: "Wi-Fi, Healing Waters, Elven Magic, Forest View",
    user_id: landlord.id
  },
  {
    name: "Wizard's Tower",
    description: "A tall tower full of mystery and ancient tomes, with a view of the nearby magical ley lines.",
    address: "789 Tower Lane, Magician's Peak",
    price_per_night: 95,
    amenities: "Wi-Fi, Potion Brewing Kit, Magical Artifacts, Stargazing Platform",
    user_id: landlord.id
  },
  {
    name: "Goblin Hideout",
    description: "A rustic, underground hideout hidden in the heart of the hills, perfect for adventurous goblins looking for a secret escape.",
    address: "1010 Goblin Hollow, Shadow Hill",
    price_per_night: 250,
    amenities: "Wi-Fi, Goblin's Forge, Hidden Treasures, Secret Tunnel",
    user_id: landlord.id
  }
]

# Create lairs in bulk
lairs.each do |lair_data|
  lair = Flat.create!(lair_data)
  puts "Created lair: #{lair.name}"  # Confirm lair creation
end

puts "Lairs seeded successfully!"

# Seeding complete
puts "Seeding complete!"
