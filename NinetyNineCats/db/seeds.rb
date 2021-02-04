# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all
CatRentalRequest.destroy_all

cat1 = Cat.create(
    name: "Purrl",
    birth_date: Date.new(2005, 1, 1),
    color: "White",
    sex: "F",
    description: "Queen Shit"
)

cat2 = Cat.create(
    name: "Grace",
    birth_date: Date.new(1992, 4, 29),
    color: "Tabby",
    sex: "F",
    description: "I'm a cat???"
)

rental1 = CatRentalRequest.create(
    cat_id: cat1.id,
    start_date: Date.new(2021, 2, 4),
    end_date: Date.new(2021, 2, 11)
)

rental2 = CatRentalRequest.create(
    cat_id: cat2.id,
    start_date: Date.new(2021, 2, 4),
    end_date: Date.new(2021, 2, 11)
)

rental3 = CatRentalRequest.create(
    cat_id: cat1.id,
    start_date: Date.new(2021, 2, 13),
    end_date: Date.new(2021, 2, 20),
    status: "APPROVED"
)