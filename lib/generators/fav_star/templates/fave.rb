class Fave < ActiveRecord::Base

  scope :for_faver, lambda { |*args| where(["faver_id = ? AND faver_type = ?", args.first.id, args.first.class.name]) }
  scope :for_faveable, lambda { |*args| where(["faveable_id = ? AND faveable_type = ?", args.first.id, args.first.class.name]) }
  scope :recent, lambda { |*args| where(["created_at > ?", (args.first || 2.weeks.ago)]) }
  scope :descending, order("created_at DESC")

  belongs_to :faveable, :polymorphic => true
  belongs_to :faver, :polymorphic => true

  attr_accessible :faver, :faveable

  validates_uniqueness_of :faveable_id, :scope => [:faveable_type, :faver_type, :faver_id]

end