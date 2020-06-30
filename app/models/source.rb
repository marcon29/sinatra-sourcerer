class Source < ActiveRecord::Base
    has_many :source_topics
    has_many :topics, through: :source_topics
    has_many :subjects, through: :topics

    # may need to specify uniqueness only for user, not as a whole???
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    # validates :url, presence: true, uniqueness: { case_sensitive: false }
    validates :topics, presence: true

    def self.find_by_slug(url_slug)
        self.all.find do |obj|
            obj.slug == url_slug
        end
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