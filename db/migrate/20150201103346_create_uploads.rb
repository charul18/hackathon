class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :name

      t.timestamps null: false
    end
    add_attachment :uploads, :file
  end
end
