# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Poem.delete_all
Title.delete_all

Title.create(title: "Apprentice Wordsmith",
  description: "You wrote your first poem on Verse.it.",
  image: "title-first.png")

Title.create(title: "Lord Tennyson",
  description: "You wrote your 10th poem on Verse.it.",
  image: "title-tennyson.png")

Title.create(title: "Let Us Go Through Certain Half-Deserted Tweets",
  description: "You wrote a poem with 70 or fewer characters.",
  image: "title-let-us.png")

Title.create(title: "Wordsworthy",
  description: "You've written 100 words on Verse.it.",
  image: "title-wordsworthy.png")

Title.create(title: "Charge of the Tweet Brigade",
  description: "You've written 600 words on Verse.it.",
  image: "title-tweet-brigade.png")

Title.create(title: "Byronic Hero",
  description: "Byron himself would be proud of your brooding words!",
  image: "title-byronic.png")

Title.create(title: "Poe-Trie",
  description: "Quoth the Raven: Forevermore! You used a three-word sequence that also appears in the poems of Edgar Allan Poe.",
  image: "title-poe.png")

Title.create(title: "Lovecraftian",
  description: "That is not dead which can eternal tweet / And with strange poems, even strangers meet.",
  image: "title-lovecraftian.png")

Title.create(title: "Duke of Repartee",
  description: "You replied to someone who wrote you a poem.",
  image: "title-repartee.png")

Title.create(title: "Rake, Progressing",
  description: "What a filthy libertine you are!",
  image: "title-rake.png")

