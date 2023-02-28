# == Schema Information
#
# Table name: collections
#
#  id          :integer          not null, primary key
#  card_number :integer
#  id_album    :integer
#  id_user     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Collection < ApplicationRecord

  belongs_to(:album, { class_name: "Album", foreign_key: "album_id"})

end
