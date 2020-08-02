class NetflixHorror::Scraper

    def self.scrape_movies
        index_page = Nokogiri::HTML(open("https://editorial.rottentomatoes.com/guide/best-netflix-horror-movies-to-watch-right-now/"))
        
        array_of_movies = index_page.css("div.countdown-item")
        
        array_of_movies.each do |movie_card| 
            attributes = {
                title: movie_card.css("div.article_movie_title a")[0].children.text, 
                url: movie_card.css("div.article_movie_title a")[0].attributes['href'].value,
                year: movie_card.css("span.start-year").text,
                rating: movie_card.css("span.tMeterScore").text,
                adjusted_score: movie_card.css("div.countdown-adjusted-score").text,
                critic_consensus: movie_card.css("div.critics-consensus").text,
                synopsis: movie_card.css("div.synopsis").text,
                starring: movie_card.css("div.cast").text,
                directed_by: movie_card.css("div.director").text,
            }
            movie = NetflixHorror::Movie.new(attributes)
            binding.pry
        end
    end

    def scrape_reviews(movie)

    end
end

