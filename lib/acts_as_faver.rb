module FavStar #:nodoc:
  module ActsAsFaver #:nodoc:

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_faver

        has_many :votes, :as => :faver, :dependent => :destroy

        include FavStar::ActsAsFaver::InstanceMethods
        extend  FavStar::ActsAsFaver::SingletonMethods

      end
    end

    module SingletonMethods
    end

    module InstanceMethods

      def faved?(faveable)
        0 < Fave.where(
              :faver_id => self.id,
              :faver_type => self.class.name,
              :faveable_id => faveable.id,
              :faveable_type => faveable.class.name
            ).count
      end

      def fave!(faveable)
        Fave.create!(:faveable => faveable, :faver => self) unless self.faved?(faveable)
      end

      def unfave!(faveable)
        Fave.where(
          :faver_id => self.id,
          :faver_type => self.class.name,
          :faveable_id => faveable.id,
          :faveable_type => faveable.class.name
        ).map(&:destroy)
      end

      def toggle_fave!(faveable)
        if self.faved?(faveable)
          unfave!(faveable)
        else
          fave!(faveable)
        end
      end

    end
  end
end