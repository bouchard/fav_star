module FavStar
  module ActsAsFaveable #:nodoc:

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_faveable
        has_many :faves, :as => :faveable, :dependent => :nullify

        include FavStar::ActsAsFaveable::InstanceMethods
        extend  FavStar::ActsAsFaveable::SingletonMethods
      end
    end

    module SingletonMethods
    end

    module InstanceMethods

      def faves
        Fave.where(:faveable_id => id, :faveable_type => self.class.name).count
      end

      def favers_who_faved
        self.faves.map(&:faver).uniq
      end

      def faved_by?(faver)
        0 < Fave.where(
              :faveable_id => self.id,
              :faveable_type => self.class.name,
              :faver_type => faver.class.name,
              :faver_id => faver.id
            ).count
      end

    end
  end
end