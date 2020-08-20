class NetflixHorror::CLI
    attr_accessor :sorted_movies
    
    def start
        greeting
        scrape_movies
        sorted_movies
        list_movies
        menu
        choose_movie #asked for input and reported a teaser of the movie
    end 

    def greeting
        puts "Welcome to the Netflix Horror app!".colorize(:red)
        puts ""
        puts "Listed below are the top 50 horror movies on Netflix according to Rotten Tomatoes:".colorize(:red).underline
        puts ""
    end

    def menu
        puts ""
        puts "Please select a number (1-50) of the corresponding movie that you would like more info on or type exit to leave:".colorize(:red)
        puts ""
    end

    def scrape_movies
        NetflixHorror::Scraper.scrape_movies
    end

    def sorted_movies
        @sorted_movies = NetflixHorror::Movie.all.sort_by{|movie| movie.title}
    end
    
    def list_movies
        @sorted_movies.each.with_index(1) do |movie,index|
            puts "#{index}. #{movie.title}"
        end
    end

    def choose_movie
        input = gets.strip
        index = input.to_i-1
        if index.between?(0,49) #a string will be -1 
            movie = @sorted_movies[index]
            puts ""
            puts "#{movie.title} #{movie.year}:".colorize(:blue)
            puts ""
            puts "Rotten Tomatoes rated this movie #{movie.rating}".colorize(:blue) #interpolation -injects the value of the variable 
            puts ""
            puts "#{movie.synopsis}".colorize(:blue)
            puts ""
            puts "#{movie.starring}".colorize(:blue)
            puts ""
            puts "#{movie.directed_by}".colorize(:blue)
            puts ""
            puts "#{movie.critic_consensus}".colorize(:blue)
            puts "" 
            read_reviews(movie)
            puts ""
            puts "Please select a number (1-50) of the corresponding movie that you would like more info on or type exit to leave:".colorize(:red)
            puts ""
            choose_movie
             
        elsif input == "exit"
            puts ""
            puts "Thank you for checking out the Netflix Horror app!".colorize(:red)
            puts ""
            #allow this method to end
        else
            puts ""
            puts "Invalid input, please try again...".colorize(:red)
            puts ""
            choose_movie #recursion- recalling a method inside a method...starts this method over again
        end
    end

    def read_reviews(movie)
        puts ""
        puts "Read reviews (Y/N)?".colorize(:red)
        puts ""
        input = gets.strip.upcase
        until ["Y","N","YES","NO"].include?(input) #input == "Y" || input =="N "
            puts ""
            puts "Please type yes(Y) or no(N)".colorize(:red)
            puts ""
            input = gets.strip.upcase
        end
        if input == "Y" || input == "YES"
            puts ""
            puts "searching for reviews.....".colorize(:red)
            puts ""
            NetflixHorror::Scraper.scrape_reviews(movie)
            movie.reviews.each do |review|
                puts ""
                puts "#{review.author} from the #{review.press} says #{review.quote}.\n\n".colorize(:blue)
            end
       end
    end
    
end 