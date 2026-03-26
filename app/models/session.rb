class Session < ApplicationRecord
  belongs_to :user
  delegate :admin?, to: :user
end
