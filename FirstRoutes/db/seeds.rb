# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all

user1 = User.create username: "GraceTveit"
user2 = User.create username: "Angrboda"

artwork1 = Artwork.create title: "pinup - SiGe",
    image_url: "https://d.facdn.net/art/angrboda/1607454014/1607453973.angrboda_sige2_pinup.jpg",
    artist_id: user2.id
artwork2 = Artwork.create title: "pinup - gibbs (latex vaporeon)",
    image_url: "https://d.facdn.net/art/angrboda/1607107696/1607107676.angrboda_gibbs6_pinup.jpg",
    artist_id: user2.id
artwork3 = Artwork.create title: "pinup - ahri",
    image_url: "https://d.facdn.net/art/angrboda/1598979967/1598979957.angrboda_ahri_pinup.jpg",
    artist_id: user2.id

share1 = ArtworkShare.create viewer_id: user1.id, artwork_id: artwork1.id
share2 = ArtworkShare.create viewer_id: user1.id, artwork_id: artwork2.id