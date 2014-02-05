class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :href
      t.string :alias
      t.integer :views, default: 0

      t.timestamps
    end
    add_index :urls, :alias, unique: true
  end
end
