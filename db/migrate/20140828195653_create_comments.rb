class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, index: true
      t.references :message, index: true
      t.integer :author_id, index: true

      t.timestamps
    end
  end
end
