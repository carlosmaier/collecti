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

  def Collection.get_my_repeated_cards(album_id,user_id)

    my_cards = Collection.all.where({:id_album => album_id }).where({ id_user: user_id}).map_relation_to_array(:card_number)
    my_repeated_cards = my_cards.find_all { |e| my_cards.count(e) > 1 }
    my_repeated_cards_unique = my_repeated_cards.uniq.sort
    
    hash_repeated_cards = Hash.new
    
    my_repeated_cards_unique.each do |a_card|
      hash_repeated_cards[a_card] = my_repeated_cards.count(a_card)
    end
    return hash_repeated_cards
  end

  def Collection.match_users_who_need_my_repeated_cards(album_id,users_id_array,repeated_cards_hash)

    hash_users_who_need_my_cards = Hash.new
    
    users_id_array.each do |a_collector|
      
      collector_cards = Collection.get_cards_from_album_and_user(album_id,a_collector)
      cards_needed = Hash.new

      repeated_cards_hash.keys.each do |a_card|
        if collector_cards.count(a_card) == 0
          cards_needed[a_card] = repeated_cards_hash.fetch(a_card)
        else end
      end
      
      hash_users_who_need_my_cards[a_collector] = cards_needed
    end
    
    return hash_users_who_need_my_cards
  end

end
