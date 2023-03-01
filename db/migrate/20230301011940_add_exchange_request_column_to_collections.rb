class AddExchangeRequestColumnToCollections < ActiveRecord::Migration[6.0]
  def change
    add_column :collections, :exchange_request, :boolean
  end
end
