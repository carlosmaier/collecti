# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  cards      :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Album < ApplicationRecord
end
