class NetflixHorror::CLI
    attr_accessor :sorted_movies
    
    def start
        greeting
        NetflixHorror::Scraper.scrape_movies
        sorted_movies
        list_movies
        puts "Please select the number of the corresponding movie that you would like more info on:"
        get_movie_method #asked for input and reported a teaser of the movie
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
            puts "#{movie.title} #{movie.year}:"
            puts "Rotten Tomatoes rated this movie #{movie.rating}"
            puts "#{movie.synopsis}"
            puts "#{movie.starring}"
            puts "#{movie.directed_by}"
            puts "#{movie.critic_consensus}" 
            want_more_info(movie)
            puts "Please select the number of the corresponding movie that you would like more info on or type exit to leave"
            get_movie_method
             
        elsif input == "exit"
            #allow this  method to end
        else
            puts "Invalid input, please try again..."
            get_movie_method #recursion
        end
    end

    def want_more_info(movie)
        puts "Read reviews (Y/N)?"
        input = gets.strip.upcase
        until ["Y","N","YES","NO"].include?(input) #input == "Y" || input =="N "
            puts "Please type Y or N"
            input = gets.strip.upcase
        end
        if input == "Y" || input == "YES"
            puts "... searching for reviews \n\n"
            NetflixHorror::Scraper.scrape_reviews(movie)
            movie.reviews.each do |review|
                puts "#{review.author} from the #{review.press} says #{review.quote}.\n\n"
            end
        else
            puts "you ended!" 
        end
    end
    
    
end 