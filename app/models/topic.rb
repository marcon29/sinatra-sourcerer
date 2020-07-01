class Topic < ActiveRecord::Base
    has_many :source_topics, :dependent => :destroy
    has_many :sources, through: :source_topics
    belongs_to :subject

    # may need to specify uniqueness only for user, not as a whole???
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :subject, presence: { message: "must select or create a subject" }

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