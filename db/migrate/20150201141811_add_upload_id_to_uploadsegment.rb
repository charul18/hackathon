class AddUploadIdToUploadsegment < ActiveRecord::Migration
  def change
    add_column :uploadsegments, :upload_id, :integer
  end
end
