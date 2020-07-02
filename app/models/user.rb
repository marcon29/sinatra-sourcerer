class User < ActiveRecord::Base
    
    # ####### join table with sources??? #######
    has_many :sources
    has_many :topics, through: :sources
    has_many :subjects, through: :sources
    # has_many :subjects, through: :topics
    
    has_secure_password

    # add format validation: no spaces, no special characters
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    
    # add format validation: text/@/text/./text, no spaces
    validates :email, presence: true, uniqueness: { case_sensitive: false }

    def full_name
        "#{self.first_name.capitalize} #{self.last_name.capitalize}"
    end


    # these slug methods are kind of pointless with above parameters for username
    # should just be able to use the username instead of slug
    def self.find_by_slug(url_slug)
        self.all.find do |obj|
            obj.slug == url_slug
        end
    end

    def slug
        self.username.gsub(" ", "-").scan(/[[^\s\W]-]/).join.downcase
    end



    
    
end