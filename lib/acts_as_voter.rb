module ThumbsUp #:nodoc:
  module ActsAsVoter #:nodoc:

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_voter

        # If a voting entity is deleted, keep the votes.
        # has_many :votes, :as => :voter, :dependent => :nullify
        # Destroy votes when a user is deleted.
        has_many :votes, :as => :voter, :dependent => :destroy

        include ThumbsUp::ActsAsVoter::InstanceMethods
        extend  ThumbsUp::ActsAsVoter::SingletonMethods
      end
    end

    # This module contains class methods
    module SingletonMethods
    end

    # This module contains instance methods
    module InstanceMethods

      # Usage user.vote_count(:up)  # All +1 votes
      #       user.vote_count(:down) # All -1 votes
      #       user.vote_count()      # All votes

      def vote_count(for_or_against = :all)
        v = Vote.where(:voter_id => id).where(:voter_type => self.class.name)
        v = case for_or_against
          when :all   then v
          when :up    then v.where(:vote => true)
          when :down  then v.where(:vote => false)
        end
        v.count
      end

      def voted_for?(voteable)
        voted_which_way?(voteable, :up)
      end

      def voted_against?(voteable)
        voted_which_way?(voteable, :down)
      end

      def voted_on?(voteable)
        0 < Vote.where(
              :voter_id => self.id,
              :voter_type => self.class.name,
              :voteable_id => voteable.id,
              :voteable_type => voteable.class.name
            ).count
      end

      def vote_for(voteable)
        self.vote(voteable, true)
      end

      def vote_against(voteable)
        self.vote(voteable, false)
      end

      def vote(voteable, vote)
        Vote.create!(:vote => vote, :voteable => voteable, :voter => self)
      end

      def voted_which_way?(voteable, direction)
        raise ArgumentError, "expected :up or :down" unless [:up, :down].include?(direction)
        0 < Vote.where(
              :voter_id => self.id,
              :voter_type => self.class.name,
              :vote => direction == :up ? true : false,
              :voteable_id => voteable.id,
              :voteable_type => voteable.class.name
            ).count
      end

    end
  end
end