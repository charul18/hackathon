class CreateUploadsegments < ActiveRecord::Migration
  def change
    create_table :uploadsegments do |t|
      t.references :upload, index: true

      t.timestamps null: false
    end
    add_foreign_key :uploadsegments, :uploads
  end
end
