class NetflixHorror::CLI
    attr_accessor :sorted_movies
    
    def start
        greeting
        NetflixHorror::Scraper.scrape_movies
        sorted_movies
        list_movies
        get_movie_method
        menu
    end 

    def greeting
        puts "Welcome to the Netflix Horror app!"
    end

    def sorted_movies
        @sorted_movies = NetflixHorror::Movie.all.sort_by{|movie| movie.title}
    end
    
    def list_movies
        @sorted_movies.each.with_index(1) do |movie,index|
            puts "#{index}. #{movie.title}"
        end
    end

    def get_movie_method
    end

    def menu
    end

    
end 