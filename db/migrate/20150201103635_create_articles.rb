class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :uploadsegment, index: true
      t.string :title
      t.string :author
      t.string :content
      t.datetime :created_at

      t.timestamps null: false
    end
    add_foreign_key :articles, :uploadsegments
  end
end
