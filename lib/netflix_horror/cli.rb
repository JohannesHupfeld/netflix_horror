class NetflixHorror::CLI
    
    def start
        greeting
        scrape_movies
        menu 
        NetflixHorror::Scraper.scrape_movies
    end 

    def greeting
        puts "Welcome to the Netflix Horror app!"
    end

    def scrape_movies
    end

    def menu
    end

    def list_movies
        NetflixHorror:Movie.all.each.with_index(1) do |movie,index|
            puts "#{index}, #{movie.title}"
        end
    end
end 