class Subject < ActiveRecord::Base
    has_many :topics, :dependent => :nullify
    has_many :sources, through: :topics
    
    # specify uniqueness only for user, not as a whole???
    validates :name, presence: true, uniqueness: { case_sensitive: false }

    def self.find_by_slug(url_slug)
        self.all.find do |obj|
            obj.slug == url_slug
        end
    end

    def slug
        self.name.gsub(" ", "-").scan(/[[^\s\W]-]/).join.downcase
    end

    def formatted_name
        self.name.split.collect { |word| word.capitalize }.join(" ")
    end
end