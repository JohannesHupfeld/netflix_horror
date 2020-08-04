class NetflixHorror::Scraper

    def self.scrape_movies
       index_page = Nokogiri::HTML(open("https://editorial.rottentomatoes.com/guide/best-netflix-horror-movies-to-watch-right-now/"))
       
       array_of_movies = index_page.css("div.countdown-item")
       
       array_of_movies[0...50].each do |movie_card| 
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

       end
    end

    def self.scrape_reviews(movie)
        review_page = Nokogiri::HTML(open(movie.url))
        review.css

        movie.review = review.css

    end
end

