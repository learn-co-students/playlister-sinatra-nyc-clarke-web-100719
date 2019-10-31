class Slug
    def self.convert(slugify)
        slugify.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
end