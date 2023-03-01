# == Schema Information
#
# Table name: collections
#
#  id               :integer          not null, primary key
#  card_number      :integer
#  exchange_request :boolean
#  id_album         :integer
#  id_user          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Collection < ApplicationRecord

  belongs_to(:album, { class_name: "Album", foreign_key: "album_id"})
  belongs_to(:user, { class_name: "User", foreign_key: "user_id"})

  def Collection.get_cards_from_album_and_user(album_id,user_id)
    collection = Collection.all.where({:id_album => album_id}).where({:id_user => user_id})
    cards = collection.map_relation_to_array(:card_number)
    return cards
  end

  def Collection.get_users_with_repeated_card(album_id,card_number,user_id)
    
    list = Collection.all.where({:id_album => album_id }).where({:card_number => card_number}).where.not({ id_user: user_id})
    collectors = list.map_relation_to_array(:id_user)
    collectors_repeated = collectors.find_all { |e| collectors.count(e) > 1 }.uniq.sort
    return collectors_repeated
  end


end
