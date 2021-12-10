# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  caption    :text
#  image      :string
#  owner      :integer
#  route      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Photo < ApplicationRecord
end
