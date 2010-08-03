autoload :Vote, 'active_record/vote'

require 'acts_as_voteable'
require 'acts_as_voter'

ActiveRecord::Base.send(:include, ThumbsUp::ActsAsVoteable)
ActiveRecord::Base.send(:include, ThumbsUp::ActsAsVoter)