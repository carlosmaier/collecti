# == Schema Information
#
# Table name: exchanges
#
#  id                     :integer          not null, primary key
#  card_number_to_receive :integer
#  card_number_to_send    :integer
#  id_receiver            :integer
#  id_sender              :integer
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  album_id               :integer
#
class Exchange < ApplicationRecord

  def Exchange.check_request(album_id,sender_id,card_send,receiver_id,card_receive)

    request = Exchange.where({album_id: album_id}).where({id_sender: sender_id}).where({card_number_to_send: card_send}).where({id_receiver: receiver_id}).where({card_number_to_receive: card_receive})

    if request.count >= 1 
      check = true
    else
      check = false
    end
    return check

  end

end
