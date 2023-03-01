class CreateExchanges < ActiveRecord::Migration[6.0]
  def change
    create_table :exchanges do |t|
      t.string :status
      t.integer :album_id
      t.integer :id_sender
      t.integer :card_number_to_send
      t.integer :id_receiver
      t.integer :card_number_to_receive

      t.timestamps
    end
  end
end
