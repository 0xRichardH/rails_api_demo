# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create! name: "Richard", email: "richard@digitalstar.tech", password: "password", password_confirmation: "password"

post = Post.create! title: "Ruby on Rails", body: "2021", author: user

2.times do |n|
  post.comments.create! body: "#{n}, I love coding. I love Ruby on Rails.", user: user
end
