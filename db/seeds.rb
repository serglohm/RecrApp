# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#Skill.destroy_all
#Company.destroy_all
#Source.destroy_all

10.times do
  Skill.create(name: Faker::ProgrammingLanguage.unique.name)
  Company.create(name: Faker::Company.unique.name)
  Source.create(name: Faker::App.unique.name)
end
