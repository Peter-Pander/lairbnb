require 'json'
require "open-uri"

# Clear existing data
puts "Clearing existing data..."
Question.destroy_all
Booking.destroy_all
Reservation.destroy_all
Flat.destroy_all
User.destroy_all


# Seeding tenants
puts "Seeding tenants..."

# Load the tenants JSON file
tenants_file = File.read('db/tenants.json')
tenants_data = JSON.parse(tenants_file)

tenant_records = {}

tenants_data.each do |tenant_info|
  tenant = User.create!(
    name: tenant_info["name"],
    email: tenant_info["email"],
    password: tenant_info["password"],
    tavern_talk: tenant_info["tavern_talk"],
    adventuring_profession: tenant_info["adventuring_profession"],
    dream_realm: tenant_info["dream_realm"],
    cursed_habit: tenant_info["cursed_habit"],
    companion_creature: tenant_info["companion_creature"],
    age_of_origin: tenant_info["age_of_origin"],
    trained_at: tenant_info["trained_at"],
    unexpected_quirk: tenant_info["unexpected_quirk"],
    useless_talent: tenant_info["useless_talent"],
    battle_song: tenant_info["battle_song"],
    tongues_you_speak: tenant_info["tongues_you_speak"],
    title_of_your_scroll: tenant_info["title_of_your_scroll"],
    enchanted_by: tenant_info["enchanted_by"],
    sleeping_conditions: tenant_info["sleeping_conditions"],
    resting_weapon: tenant_info["resting_weapon"],
    travel_style: tenant_info["travel_style"]
  )

  # Attach tenant image if the URL is provided
  if tenant_info["image"].present?
    file = URI.open(tenant_info["image"])
    tenant.photo.attach(io: file, filename: "tenant_image_#{tenant.name.parameterize}.jpg", content_type: "image/jpeg")
  end

  tenant_records[tenant_info["email"]] = tenant
  puts "Created tenant: #{tenant.email} with image #{tenant_info["image"]}"
end


puts "Tenants seeded successfully!"
# Seeding landlords
puts "Seeding landlords..."

# Load the landlords JSON file
landlords_file = File.read('db/landlords.json')
landlords_data = JSON.parse(landlords_file)

landlord_records = {}

landlords_data.each do |landlord_data|
  landlord = User.create!(
    name: landlord_data["name"],
    email: landlord_data["email"],
    password: landlord_data["password"],
    role: :landlord,
    tavern_talk: landlord_data["tavern_talk"],
    adventuring_profession: landlord_data["adventuring_profession"],
    dream_realm: landlord_data["dream_realm"],
    cursed_habit: landlord_data["cursed_habit"],
    companion_creature: landlord_data["companion_creature"],
    age_of_origin: landlord_data["age_of_origin"],
    trained_at: landlord_data["trained_at"],
    unexpected_quirk: landlord_data["unexpected_quirk"],
    useless_talent: landlord_data["useless_talent"],
    battle_song: landlord_data["battle_song"],
    tongues_you_speak: landlord_data["tongues_you_speak"],
    title_of_your_scroll: landlord_data["title_of_your_scroll"],
    enchanted_by: landlord_data["enchanted_by"],
    sleeping_conditions: landlord_data["sleeping_conditions"],
    resting_weapon: landlord_data["resting_weapon"],
    travel_style: landlord_data["travel_style"],
    innkeeping_philosophy: landlord_data["innkeeping_philosophy"]
  )

  # Attach the landlord image if the URL is provided
  if landlord_data["landlord_image"].present?
    file = URI.open(landlord_data["landlord_image"])
    landlord.photo.attach(io: file, filename: "landlord_image_#{landlord.name.parameterize}.jpg", content_type: "image/jpeg")
  end

  landlord_records[landlord_data["email"]] = landlord
  puts "Created landlord: #{landlord.email} with image #{landlord_data["landlord_image"]}"
end

puts "Landlords seeded successfully!"

puts "Seeding lairs"
# Load lair data from JSON file
lairs_data = JSON.parse(File.read(Rails.root.join('db', 'lairs.json')))

# Create lairs and attach images
lairs_data.each do |lair_data|
  landlord = landlord_records[lair_data["landlord_email"]] # Get the correct landlord

  # Ensure landlord exists before creating the flat
  if landlord.nil?
    puts "Error: No landlord found for email #{lair_data['landlord_email']}"
    next
  end

  lair = Flat.create!(
    name: lair_data["name"],
    description: lair_data["description"],
    address: lair_data["address"],
    price_per_night: lair_data["price_per_night"],
    amenities: lair_data["amenities"],
    user: landlord # Assign correct landlord
  )

  # Attach image from Cloudinary
  file = URI.open(lair_data["image_url"])
  lair.photo.attach(io: file, filename: "#{lair.name.parameterize}.jpg", content_type: "image/jpeg")

  puts "Created lair: #{lair.name} with landlord #{landlord.name} and image #{lair_data['image_url']}"
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
