# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
TagTopic.destroy_all
tag1 = TagTopic.create topic: "development test"
tag2 = TagTopic.create topic: "search engine"
tag3 = TagTopic.create topic: "social media"

Tagging.destroy_all
tagging1 = Tagging.create shortened_url_id: 1, tag_topic_id: tag1.id
tagging2 = Tagging.create shortened_url_id: 2, tag_topic_id: tag2.id
tagging3 = Tagging.create shortened_url_id: 3, tag_topic_id: tag2.id
tagging4 = Tagging.create shortened_url_id: 4, tag_topic_id: tag3.id
tagging5 = Tagging.create shortened_url_id: 5, tag_topic_id: tag3.id
tagging6 = Tagging.create shortened_url_id: 6, tag_topic_id: tag2.id
tagging7 = Tagging.create shortened_url_id: 7, tag_topic_id: tag2.id
tagging8 = Tagging.create shortened_url_id: 8, tag_topic_id: tag2.id