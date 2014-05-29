class CreateSubmenus < ActiveRecord::Migration
  def change
    create_table :submenus do |t|
      t.string :title
      t.integer :menu

      t.integer :position
      t.timestamps
    end
  end
end
