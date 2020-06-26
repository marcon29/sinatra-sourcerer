class Topic < ActiveRecord::Base
    has_many :source_topics
    has_many :sources, through: :source_topics
    belongs_to :subject

    def self.find_by_slug(url_slug)
        self.all.find do |obj|
            obj.slug == url_slug
        end
    end    

    def slug
        self.name.gsub(" ", "-").scan(/[[^\s\W]-]/).join.downcase
    end
end