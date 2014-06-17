class ChangeColumnInUploads < ActiveRecord::Migration
  def change
    rename_column :uploads, :type, :content_type
  end
end
