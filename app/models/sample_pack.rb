class SamplePack < ApplicationRecord
  has_many :samples, dependent: :destroy
  has_one_attached :cover_art
end
