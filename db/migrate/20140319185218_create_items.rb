class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.text :body

      t.integer :menu

      t.integer :position
      t.timestamps
    end
  end
end
