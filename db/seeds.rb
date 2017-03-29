# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

CSV.foreach('db/chemicals.csv') do |row|
  registerd_at = row[10].split("/")
  registerd_end = row[11].split("/")
  Chemical.create(
    :code => row[0],
    :category => row[1],
    :name => row[2],
    :official_name => row[3],
    :ingredient => row[4],
    :active_ingredient => row[5],
    :concentration => row[6],
    :mixture_count => row[7],
    :usefulness => row[8],
    :use_category => row[9],
    :registered_at => Time.mktime(registerd_at[2],registerd_at[0],registerd_at[1]),
    :registered_end => Time.mktime(registerd_end[2],registerd_at[0],registerd_at[1]),
    :created_at => Time.now,
    :updated_at => Time.now
  )
end
