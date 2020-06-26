class Source < ActiveRecord::Base
    has_many :source_topics
    has_many :topics, through: :source_topics
    has_many :subjects, through: :topics

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
end