class NetflixHorror::Movie
    attr_accessor :title, :url, :year, :rating, :adjusted_score, :critic_consensus, :synopsis, :starring, :directed_by 
    attr_reader :reviews  
    
    @@all = []
    
    def initialize(att_hash)
       #@title = att_hash[:title],
       #@url = att_hash[:url],
       #@year = att_hash[:year],
       #@rating = att_hash[:rating],
       #@adjusted_score = att_hash[:adjusted_score],
       #@critic_consensus = att_hash[:critic_consensus],
       #@synopsis = att_hash[:synopsis],
       #@starring = att_hash[:starring],
       #@directed_by = att_hash[:directed_by]
        
        att_hash.each do |key, value|
            self.send("#{key}=", value)
        #itterates through the hash, then calling the method self.send method to whatever our key is then assigns it to a value. 
        #first key is title and then the value is what we pass through it.
        end
        @reviews = []
        self.save
    end

    def save
        @@all << self
        self
    end

    def self.all
        @@all
    end

    def add_review(rev)
        @reviews << rev
        rev.movie = self
    end

    
end