class CreateTrails < ActiveRecord::Migration[6.0]
  def change
    create_table :trails do |t|
      t.string :route
      t.string :name
      t.text :disc
      t.float :length
      t.float :pr
      t.integer :owner_id
      t.integer :comments_count

      t.timestamps
    end
  end
end
