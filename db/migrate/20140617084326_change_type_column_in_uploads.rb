class ChangeTypeColumnInUploads < ActiveRecord::Migration
  def change
    rename_column :uploads, :type_id, :type
    change_column :uploads, :type, :string
  end
end
