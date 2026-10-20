class User < ApplicationRecord
  has_secure_password

  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  has_many :bookmarks, dependent: :destroy

  validates :mail, presence: { message: "を入力してください" }, uniqueness: { message: "はすでに使用されています" }
  validates :name, presence: { message: "を入力してください" }
  
  validates :password, presence: { message: "を入力してください" }, length: { minimum: 6, message: "は6文字以上で入力してください" }, allow_nil: true
end