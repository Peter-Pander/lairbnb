require 'json'
require "open-uri"

# Clear existing data
puts "Clearing existing data..."
Question.destroy_all
Booking.destroy_all
Reservation.destroy_all
Flat.destroy_all
User.destroy_all

# Seeding Users
puts "Seeding users..."

landlord = User.create!(
  name: 'landlord',
  email: 'landlord@example.com',
  password: 'sandwich'
)

tenant = User.create!(
  name: 'tenant',
  email: 'tenant@example.com',
  password: 'sandwich'
)

puts "Users seeded successfully!"


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
    password: landlord_data["password"]
  )

  # Attach the landlord image if the URL is provided
  if landlord_data["landlord_image"].present?
    file = URI.open(landlord_data["landlord_image"])
    landlord.photo.attach(io: file, filename: "landlord_image_#{landlord.name.parameterize}.jpg", content_type: "image/jpeg")
  end

  landlord_records[landlord_data["email"]] = landlord
  puts "Created landlord: #{landlord.email} with image #{landlord_data["landlord_image"]}"
end


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

puts "Lairs and users seeded successfully!"


# Seeding homepage background
puts "Seeding homepage background..."

homepage_background_url = 'https://res.cloudinary.com/dadymzua9/image/upload/v1/landingpage_niljab'
homepage_background = HomepageBackground.create!

# Attach image from Cloudinary
file = URI.open(homepage_background_url)
homepage_background.photo.attach(io: file, filename: "homepage_background.jpg", content_type: "image/jpeg")

puts "Homepage background seeded successfully!"
