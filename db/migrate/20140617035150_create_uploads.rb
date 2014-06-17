class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :name
      t.integer :size
      t.integer :type_id
      t.string :path

      t.timestamps
    end

    add_index :uploads, :path, unique:true
  end
end
