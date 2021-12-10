# == Schema Information
#
# Table name: trails
#
#  id             :integer          not null, primary key
#  comments_count :integer
#  disc           :text
#  length         :float
#  name           :string
#  pr             :float
#  route          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Trail < ApplicationRecord
end
