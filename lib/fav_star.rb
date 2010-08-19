require 'acts_as_faveable'
require 'acts_as_faver'

ActiveRecord::Base.send(:include, FavStar::ActsAsFaveable)
ActiveRecord::Base.send(:include, FavStar::ActsAsFaver)