class Source < ActiveRecord::Base
    has_many :source_topics, :dependent => :destroy
    has_many :topics, through: :source_topics
    has_many :subjects, through: :topics
    belongs_to :user
        
    validates :topics, presence: { message: "must select or create a topic" }
    validates :user, presence: true
    validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user }
    validates :url, presence: true, uniqueness: { case_sensitive: false, scope: :user }    
    before_validation :format_url
   
    def format_url
        string = self.url.gsub(/(https:\/\/|http:\/\/)?(www.)?/, "").strip
        string.ends_with?('/') ? string = string.chomp("/") : string

        if !string.empty?
            self.url = "www." << string
        end
    end

    def self.media_options
        ["Audio", 
        "Video", 
        "Image", 
        "News Article", 
        "Blog Article", 
        "Study", 
        "PDF", 
        "Other"]
    end

    def self.find_by_slug(url_slug)
        self.all.find { |obj| obj.slug == url_slug }
    end

    def slug
        self.name.gsub(" ", "-").scan(/[[^\s\W]-]/).join.downcase
    end

    def formatted_name
        self.name.split.collect { |word| word.capitalize }.join(" ")
    end
end