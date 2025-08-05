class CreateRemoteIqdbMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :remote_iqdb_matches do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :remote_file_size
      t.integer :remote_file_type
      t.integer :remote_width
      t.integer :remote_height
      t.float :remote_compression
      t.float :simularity
      t.integer :remote_id
      t.integer :remote_status
      t.string :remote_md5
      t.integer :remote_source
      t.integer :bit_depth, limit: 1
      t.integer :flags, limit: 1

      t.timestamps
    end
  end
end
