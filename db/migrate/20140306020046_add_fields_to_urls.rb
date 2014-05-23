class AddFieldsToUrls < ActiveRecord::Migration
  def change
    change_table :urls do |t|
      t.boolean :sticky
      t.boolean :custom
    end
  end
end
