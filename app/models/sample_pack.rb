class SamplePack < ApplicationRecord
  has_many :samples, dependent: :destroy
end
