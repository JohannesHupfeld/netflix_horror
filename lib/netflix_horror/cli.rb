class NetflixHorror::CLI
    attr_accessor :sorted_movies
    
    def start
        greeting
        NetflixHorror::Scraper.scrape_movies
        sorted_movies
        list_movies
        puts "Please select a number (1-50) of the corresponding movie that you would like more info on or type exit to leave:".colorize(:red)
        get_movie_method #asked for input and reported a teaser of the movie
    end 

    def greeting
        puts "Welcome to the Netflix Horror app!".colorize(:red)
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
            puts "#{movie.title} #{movie.year}:".colorize(:blue)
            puts ""
            puts "Rotten Tomatoes rated this movie #{movie.rating}".colorize(:blue)
            puts ""
            puts "#{movie.synopsis}".colorize(:blue)
            puts ""
            puts "#{movie.starring}".colorize(:blue)
            puts ""
            puts "#{movie.directed_by}".colorize(:blue)
            puts ""
            puts "#{movie.critic_consensus}".colorize(:blue)
            puts "" 
            want_more_info(movie)
            puts "Please select a number (1-50) of the corresponding movie that you would like more info on or type exit to leave:".colorize(:red)
            get_movie_method
             
        elsif input == "exit"
            #allow this  method to end
        else
            puts "Invalid input, please try again...".colorize(:red)
            get_movie_method #recursion
        end
    end

    def want_more_info(movie)
        puts "Read reviews (Y/N)?".colorize(:red)
        input = gets.strip.upcase
        until ["Y","N","YES","NO"].include?(input) #input == "Y" || input =="N "
            puts "Please type yes/Y or no/N".colorize(:red)
            input = gets.strip.upcase
        end
        if input == "Y" || input == "YES"
            puts "... searching for reviews \n\n".colorize(:red)
            NetflixHorror::Scraper.scrape_reviews(movie)
            movie.reviews.each do |review|
                puts "#{review.author} from the #{review.press} says #{review.quote}.\n\n".colorize(:blue)
            end
        else
            puts "Thank you for checking out the Netflix Horror app!".colorize(:red)
        end
    end
    
    
end 