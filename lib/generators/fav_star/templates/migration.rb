class FavStarMigration < ActiveRecord::Migration
  def self.up

    create_table :faves, :force => true do |t|
      t.references :faveable, :polymorphic => true, :null => false
      t.references :faver,    :polymorphic => true
      t.timestamps
    end

    add_index :faves, ["faver_id", "faver_type"],       :name => "fk_favers"
    add_index :faves, ["faveable_id", "faveable_type"], :name => "fk_faveables"
    add_index :faves, ["faver_id", "faver_type", "faveable_id", "faveable_type"], :unique => true, :name => "only_one_fav_per_user"

  end

  def self.down

    drop_table :faves

  end

end
