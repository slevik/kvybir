class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :description
      t.text :body
      t.string :cdate
      t.timestamps
    end
  end
end
