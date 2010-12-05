class FavStarMigration < ActiveRecord::Migration
  def self.up

    create_table :faves, :force => true do |t|
      t.references :faveable, :polymorphic => true, :null => false
      t.references :faver,    :polymorphic => true
      t.timestamps
    end

    add_index :faves, [:faver_id, :faver_type]
    add_index :faves, [:faveable_id, :faveable_type]
    
    # Only one fave per user, per model.
    add_index :faves, [:faver_id, :faver_type, :faveable_id, :faveable_type], :unique => true, :name => 'fk_one_fave_per_user_per_model'

  end

  def self.down

    drop_table :faves

  end

end