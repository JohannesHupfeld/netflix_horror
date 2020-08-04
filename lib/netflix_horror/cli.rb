class NetflixHorror::CLI
    attr_accessor :sorted_movies
    
    def start
        greeting
        NetflixHorror::Scraper.scrape_movies
        sorted_movies
        list_movies
        puts "Please select the number of the corresponding movie that you would like more info on:"
        get_movie_method #asked for input and reported a teaser of the movie
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
        input = gets.strip
        index = input.to_i-1
        if index.between?(0,49) #a string will be -1 
            movie = @sorted_movies[index]
            puts "#{movie.title}:"
            puts "Rotten Tomatoes rated this movie #{movie.rating}"
            puts "#{movie.critic_consensus}" 
            want_more_info(movie)
        elsif input == "exit"
            #allow this  method to end
        else
            puts "Invalid input, please try again..."
            get_movie_method #recursion
        end
    end

    def want_more_info(movie)
        puts "Read more? (Y/N)"
        input = "nil"
        until input == "Y" || input == "N"
            puts "Type Y(yes) or N(no)"
            input = gets.strip.upcase
        end
        if input = "y"
            #2nd scape
        else
            puts "you ended! " 
        end
    end


    def menu
    end

    
end 