# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
hotel = Hotel.where(external_id: ENV.fetch('SMOOCH_APP_ID')).first_or_create!(
  name:   'My Hotel',
  phone: '+1 (234) 567-8912'
)
emails = ['usman@chatapp.com', 'lorem@chatapp.com']
names = ['Usman Asif', 'Lorem']
2.times do |i|
  User.where(email: emails[i]).first_or_create!(
    password:              'helloworld81@',
    password_confirmation: 'helloworld81@',
    profile:               { name: names[i] },
    hotel: hotel
  )
end

# Create checked-in/out guests
10.times do |i|
  guest = Guest.where(external_id: "dummyid-#{i}").first_or_create! do |g|
    g.profile = { name: "Guest #{i + 1}" }
  end

  check_in = guest.check_ins.where(hotel: hotel).first_or_create!
  check_in.update(checked_out_at: Time.current) if i >= 4
end

# Create dummy messages
guest = hotel.guests.first
user = hotel.users.first
5.times do |i|
  rem = (i + 1) % 2
  Message.create!(
    hotel: hotel,
    guest: guest,
    user: (rem.zero? ? user : nil),
    content: "This is a dummy text #{i}"
  )
end
