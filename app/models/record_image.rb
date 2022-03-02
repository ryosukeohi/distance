class RecordImage < ApplicationRecord
  belongs_to :record
  attachment :image
end
