class CreateRemoteIqdbMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :remote_iqdb_matches do |t|
      t.references :post, null: false, foreign_key: true
      t.references :base_file_data, null: false, foreign_key: true
      t.float :simularity
      t.integer :remote_id
      t.integer :remote_status
      t.integer :remote_source

      t.timestamps
    end
  end
end
