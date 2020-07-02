class Subject < ActiveRecord::Base
    has_many :topics, :dependent => :nullify
    has_many :sources, through: :topics
    belongs_to :user
    
    validates :user, presence: true
    validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user }

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