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
               starring: movie_card.css("div.cast").text.strip,
               directed_by: movie_card.css("div.director").text.strip,
           }
           movie = NetflixHorror::Movie.new(attributes)

       end
    end

    def self.scrape_reviews(movie_object)

        review_page = Nokogiri::HTML(open(movie_object.url))
        reviews = review_page.css("li.top_critic") #array of reviews
        
        reviews.each do |review_html|  
            #instantiate a new review 
            #associate that review with this movie
            #set any review attributes
        
        ro = NetflixHorror::Review.new  
           
        ro.quote = review_html.css("div.media blockquote.media-body p").text.strip
        ro.author = review_html.css("div.review_source a.unstyled").text
        ro.press = review_html.css("div.review_source a.subtle").text

        movie_object.add_review(ro)
        #add this review to movie.reviews
        end    
    end

end


