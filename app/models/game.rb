class Game < ActiveRecord::Base
    belongs_to :user

    def slug
        @slug = self.name.parameterize
        @slug
    end

    def self.find_by_slug(slug)
        @song = Song.all.find do |song|
            song.slug == slug
        end
        @song     
    end
    
end
