class User < ApplicationRecord
  has_secure_password


  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  has_many :bookmarks, dependent: :destroy

  validates :mail, presence: true, uniqueness: true
  validates :name, presence: true
end
