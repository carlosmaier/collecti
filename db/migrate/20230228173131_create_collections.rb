class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.integer :id_user
      t.integer :id_album
      t.integer :card_number

      t.timestamps
    end
  end
end
