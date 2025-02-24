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
    description: "The Dolomites, with their jagged peaks and dramatic cliffs,
    are a landscape shaped by the forces of nature, where dragons call home.
    The towering spires of rock and vast, rugged terrain form a natural fortress,
    providing rest and refuge for ancient creatures.
    The beauty and raw power of this region are undeniable,
    with vistas stretching far beyond the eye can see, where dragons soar above.
    Every crag and crevice holds the echo of mythical beings,
    while the silence of the mountains serves as a reminder of their enduring presence.",
    address: "123 Dragonridge, Firepeak Mountain, Dolomites, Italy 🇮🇹",
    price_per_night: 75,
    amenities: "Wi-Fi, Dragon's Roar Fireplace, Treasure Chest, Mountain View, Dragon's Wing Hammocks, Volcanic Spring Hot Tub, Stone Carving Studio, Fireproof Walls, Mountain Echo Sound System, Dragon Rider's Stables, Hoard of Gold, Scales of Power Ritual Area, Roaring Waterfall, Cloud Gazing Deck, High Altitude Lounge",
    image_url: "https://res.cloudinary.com/dadymzua9/image/upload/v1/dragonsden237_krf9v1.jpg"
  },
  {
    name: "Elven Treehouse",
    description: "In the heart of Yakushima Forest, ancient, moss-covered trees reach up to the sky, hiding the Elven Treehouse among their branches. The forest, shrouded in mist and mystery, creates an atmosphere of peace and enchantment, where the elves have long made their home. Towering cedars and lush greenery form a natural canopy, where treehouses high in the boughs offer a retreat from the world below. The magic of nature flows through every leaf and root, and the harmony of the forest resonates with those attuned to the spirit of the elves, offering serenity and hidden wonders within the mist.",
    address: "456 Forest Glade, Eldertree, Yakushima Forest, Japan 🇯🇵",
    price_per_night: 120,
    amenities: "Wi-Fi, Healing Waters, Elven Magic, Forest View, Moonlit Glade, Enchanted Tree Swing, Sacred Herb Garden, Elven Craftsmanship Workshop, Starlight Weaver's Loom, Moss-Covered Meditation Spots, Spirit of the Forest Incense, Ancient Oak Throne, Elven Lyre Music, Crystal Clear Spring, Celestial Dome Viewing, Elven Storytelling Circle",
    image_url: "https://res.cloudinary.com/dadymzua9/image/upload/v1/Elven_Treehouse_kgs03p.jpg"
  },
  {
    name: "Wizard's Tower",
    description: "The Old Man of Storr, on the Isle of Skye, stands as a monument to the mystical forces of nature, rising above the mist like the Wizard’s Tower. Its towering rock formations and eerie landscapes are steeped in ancient energy, making it a perfect site for the study of arcane knowledge. The windswept hills and jagged peaks are an ideal setting for wizards to contemplate their craft, with ley lines of magic coursing through the earth beneath. As the mists roll in, the mountain seems to come alive, offering a powerful connection to the unseen worlds, where magic is as much a part of the landscape as the rocks themselves.",
    address: "789 Tower Lane, Magician's Peak, Isle of Skye, Scotland 🇬🇧",
    price_per_night: 95,
    amenities: "Wi-Fi, Potion Brewing Kit, Magical Artifacts, Stargazing Platform, Crystal Ball Observation, Alchemical Lab, Arcane Energy Converter, Spellbook Library, Enchanted Mirror, Wizard's Familiar Suite, Astral Projection Viewing Room, Floating Candles, Dragonfly Wing Enchantment, Elemental Runes, Thunderstorm Viewing Area",
    image_url: "https://res.cloudinary.com/dadymzua9/image/upload/v1/wizardstower3234_eupz68.jpg"
  },
  {
    name: "Goblin Hideout",
    description: "Cappadocia’s striking, surreal landscape of fairy chimneys and ancient rock dwellings is where the Goblin Hideout can be found. Beneath its rocky surface, labyrinthine tunnels and hidden chambers extend for miles, where goblins have long made their home, guarding their treasures and secrets. The soft volcanic rock that forms Cappadocia’s iconic shapes is ideal for carving, giving the goblins ample space to create their hidden lairs and forges. The beauty of this region lies in its contrasts — the breathtaking natural formations above ground conceal a rich, secret world below, where goblins have thrived for centuries, far from the eyes of ordinary folk.",
    address: "1010 Goblin Hollow, Shadow Hill, Cappadocia, Turkey 🇹🇷",
    price_per_night: 250,
    amenities: "Wi-Fi, Goblin's Forge, Hidden Treasures, Secret Tunnel, Smuggler's Passage, Underground Dining Hall, Goblin Tinkerer's Workshop, Poisoned Dart Practice Room, Explosive Ingredient Storage, Gold and Gemstone Vault, Ancient Mine Cart Tracks, Goblin Minstrels, Cursed Chalice Bar, Shadow Cloak Stash, Underground Fire Pit, Goblin Shadow Projection Room",
    image_url: "https://res.cloudinary.com/dadymzua9/image/upload/v1/Goblin_Hideout2_oh5myx.jpg"
  },
  {
    name: "Dwarven Stronghold",
    description: "The Erzgebirge, with its deep mining history and towering mountain peaks, is the home of the Dwarven Stronghold. Beneath the surface, vast networks of tunnels and halls are carved from solid rock, housing the wealth and craftsmanship of generations of dwarves. The region’s rich deposits of precious metals and stones have long attracted the dwarves, who have turned the mountains into living monuments to their skill and resilience. The clang of the blacksmith’s hammer still echoes through the valleys, and the air is filled with the scent of smelted metal and the glow of forge fires. Above ground, the lush forests and peaceful villages hold the contrast of the industrious and secretive world that lies below, where the dwarves continue their work, hidden from the world above.",
    address: "2222 Granite Keep, Irondeep Mountains, Erzgebirge, Germany 🇩🇪 & Czech Republic 🇨🇿",
    price_per_night: 110,
    amenities: "Wi-Fi, Smithy, Mead Hall, Gemstone Vault, Forge Room, Dwarven Ale Brewery, Hammerfall Arena, Weapon Crafting Studio, Ancient Mine Lair, Lava Forge, Hearthstone Room, Rune Inscribed Walls, Dwarven Shield Rack, Cold Iron Forge, Tunnel Access to Hidden Vaults, Stone-Engraved Maps, Earthquake Safe Chamber",
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

# Seeding homepage background
puts "Seeding homepage background..."

homepage_background_url = 'https://res.cloudinary.com/dadymzua9/image/upload/v1/landingpage_niljab'
homepage_background = HomepageBackground.create!

# Attach image from Cloudinary
file = URI.open(homepage_background_url)
homepage_background.photo.attach(io: file, filename: "homepage_background.jpg", content_type: "image/jpeg")

puts "Homepage background seeded successfully!"
