class Question < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :subject

  has_many :answers, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

end
