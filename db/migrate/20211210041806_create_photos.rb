class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.text :caption
      t.string :image
      t.integer :owner
      t.integer :route

      t.timestamps
    end
  end
end
