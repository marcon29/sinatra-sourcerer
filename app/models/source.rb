class Source < ActiveRecord::Base
    has_many :source_topics, :dependent => :destroy
    has_many :topics, through: :source_topics
    has_many :subjects, through: :topics
    belongs_to :user
        
    validates :topics, presence: { message: "must select or create a topic" }
    validates :user, presence: true
    validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user }    
        
    # add validation condition: ignore http/https and www.
    # validates :url, presence: true, uniqueness: { case_sensitive: false, scope: :user }
        

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

    def link
        self.url.downcase.gsub(/(https:\/\/|http:\/\/)/, "")
    end

    def formatted_name
        self.name.split.collect { |word| word.capitalize }.join(" ")
    end
end