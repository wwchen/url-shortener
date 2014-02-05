class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :original
      t.text :compressed
      t.integer :views

      t.timestamps
    end
    add_index :urls, :compressed, unique: true
  end
end
