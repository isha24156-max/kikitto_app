# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 学年の初期データ
(1..3).each do |number|
  Grade.find_or_create_by!(g_number: number)
end

# クラスの初期データ
(1..4).each do |number|
  Course.find_or_create_by!(c_number: number)
end