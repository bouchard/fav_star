class Vote < ActiveRecord::Base

  scope :for_voter, lambda { |*args| where(:voter_id => args.first.id, :voter_type => args.first.type.name) }
  scope :for_voteable, lambda { |*args| where(:voteable_id => args.first.id, :voteable_type => args.first.type.name) }
  scope :recent, lambda { |*args| where('created_at', (args.first || 2.weeks.ago)) }
  scope :descending, order('created_at DESC')

  belongs_to :voteable, :polymorphic => true
  belongs_to :voter,    :polymorphic => true

  attr_accessible :vote, :voter, :voteable

  # Comment out the line below if you want to allow multiple votes per voter.
  validates_uniqueness_of :voteable_id, :scope => [:voteable_type, :voter_type, :voter_id]

end