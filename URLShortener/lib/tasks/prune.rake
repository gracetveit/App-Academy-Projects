namespace :prune do
    task prune_urls: :environment do
        puts "Purging all old URLs"
        ShortenedUrl.prune(43200)
    end
end