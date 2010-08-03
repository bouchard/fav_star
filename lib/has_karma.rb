module ThumbsUp #:nodoc:
  module Karma #:nodoc:

    def self.included(base)
      base.extend ClassMethods
      class << base
        attr_accessor :karmic_objects
      end
    end

    module ClassMethods
      def has_karma(voteable_type, options = {})
        include ThumbsUp::Karma::InstanceMethods
        extend  ThumbsUp::Karma::SingletonMethods
        self.karmic_objects ||= {}
        self.karmic_objects[voteable_type.to_s.classify.constantize] = (options[:as] ? options[:as].to_s.foreign_key : self.class.name.foreign_key)
      end
    end

    module SingletonMethods

      ## Not yet implemented. Don't use it!
      # Find the most popular users
      def find_most_karmic
        find(:all)
      end

    end

    module InstanceMethods
      def karma(options = {})
        self.class.karmic_objects.collect do |object, fk|
          v = object.where(["#{Vote.table_name}.vote = ?", true]).where(["#{self.class.table_name}.#{self.class.primary_key} = ?", self.id])
          v = v.joins("INNER JOIN #{Vote.table_name} ON #{Vote.table_name}.voteable_type = '#{object.to_s}' AND #{Vote.table_name}.voteable_id = #{object.table_name}.#{object.primary_key}")
          v = v.joins("INNER JOIN #{self.class.table_name} ON #{self.class.table_name}.#{self.class.primary_key} = #{object.table_name}.#{fk}")
          v.count
        end.sum
      end
    end

  end
end
