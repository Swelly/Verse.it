# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Title.delete_all

Title.create(title: "Apprentice Wordsmith", image: "app/assets/images/first-title.jpg")
Title.create(title: "Let Us Go Through Certain Half-Deserted Tweets", image: "app/assets/images/title-let-us.jpg")