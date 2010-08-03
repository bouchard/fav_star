ThumbsUp
=======

Allows an arbitrary number of entities (users, etc.) to vote on models.

### Mixins
This plugin introduces two mixins to your recipe book:

1. **acts\_as\_voteable** : Intended for content objects like Posts, Comments, etc.
2. **acts\_as\_voter** : Intended for voting entities, like Users.

### Inspiration

This plugin started as an adaptation / update of vote\_fu for use with Rails 3. It adds some speed, removes some cruft, and is adapted for use with ActiveRecord / Arel in Rails 3. It maintains the awesomeness of the original vote\_fu.

Installation
============

### Require the gem:

    gem 'thumbs_up'

### Create and run the ThumbsUp migration:

    rails generate thumbs_up
    rake db:migrate

Usage
=====

## Getting Started

### Turn your AR model into something that can be voted upon.

    class Model < ActiveRecord::Base
      acts_as_voteable
    end

### Turn your Users (or any other model) into voters.

    class User < ActiveRecord::Base
      acts_as_voter
    end

    class Robot < ActiveRecord::Base
      acts_as_voter
    end

### To cast a vote for a Model you can do the following:

#### Shorthand syntax
  voter.vote_for(voteable)     	# Adds a +1 vote
  voter.vote_against(voteable) 	# Adds a -1 vote
  voter.vote(voteable, vote) 	# Adds either a +1 or -1 vote: vote => true (+1), vote => false (-1)

### Querying votes

Did the first user vote for the Car with id = 2 already?

    u = User.first
	u.voted_on?(Car.find(2))

#### Tallying Votes

You can easily retrieve voteable object collections based on the properties of their votes:

    @items = Item.tally(
      {  :at_least => 1,
          :at_most => 10000,
          :start_at => 2.weeks.ago,
          :end_at => 1.day.ago,
          :limit => 10,
          :order => "items.name DESC"
      })

This will select the Items with between 1 and 10,000 votes, the votes having been cast within the last two weeks (not including today), then display the 10 last items in an alphabetical list.

##### Tally Options:
    :start_at    - Restrict the votes to those created after a certain time
    :end_at      - Restrict the votes to those created before a certain time
    :conditions  - A piece of SQL conditions to add to the query
    :limit       - The maximum number of voteables to return
    :order       - A piece of SQL to order by. Eg 'votes.count desc' or 'voteable.created_at desc'
    :at_least    - Item must have at least X votes
    :at_most     - Item may not have more than X votes

#### Lower level queries
ActiveRecord models that act as voteable can be queried for the positive votes, negative votes, and a total vote count by using the votes\_for, votes\_against, and votes\_count methods respectively. Here is an example:

    positiveVoteCount = m.votes_for
    negativeVoteCount = m.votes_against
    totalVoteCount    = m.votes_count

And because the Vote Fu plugin will add the has_many votes relationship to your model you can always get all the votes by using the votes property:

    allVotes = m.votes

The mixin also provides these methods:

  voter.voted_for?(voteable)  # True if the voter voted for this object.
  voter.vote_count(:up | :down | :all) # returns the count of +1, -1, or all votes

  voteable.voted_by?(voter) # True if the voter voted for this object.
  @voters = voteable.voters_who_voted


### One vote per user!

ThumbsUp by default only allows one vote per user. This can be changed by removing:

#### In vote.rb:

    validates_uniqueness_of :voteable_id, :scope => [:voteable_type, :voter_type, :voter_id]

#### In the migration:

    add_index :votes, ["voter_id", "voter_type", "voteable_id", "voteable_type"], :unique => true, :name => "uniq_one_vote_only"


Credits
=======

Basic structure and a good chunk of code is taken from Peter Jackson's work on ActsAsVoteable.