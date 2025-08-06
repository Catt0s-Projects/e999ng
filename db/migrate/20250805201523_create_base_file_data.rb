class CreateBaseFileData < ActiveRecord::Migration[7.1]
  def change
    create_table :base_file_data do |t|
      t.integer :file_type
      t.integer :file_size
      t.integer :width
      t.integer :depth
      t.integer :height
      t.string :md5
      t.integer :flags
      t.float :compression
      t.string  :file_name

      t.timestamps
    end
  end
end
