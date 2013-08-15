class CreateSubJoinLinks < ActiveRecord::Migration
  def change
    create_table :sub_join_links do |t|
      t.integer :sub_id
      t.integer :link_id

      t.timestamps
    end
  end
end
