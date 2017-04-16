########################################################
# Name:Build DB
# Auther:agri
# Date:2017/4/15
########################################################
require 'pg'
require 'yaml'
#require '../build_util'
#
#include CreateDatabase

T = YAML.load_file('../tables/scheme.yml')
db_conig = {
  host:     '127.0.0.1',
  user:     'agri',
  password: '',
  dbname:   'agri',
  port:     '5432'
}
connection = PG.connect(db_conig)
connection.internal_encoding = 'UTF-8'
puts 'DBconnect'
puts '--------------------------------'
puts T["scheme"]
query = "CREATE TABLE "
query += T["scheme"][0]["name"] + "("

a = T["scheme"][0]["cols"]
ary = []
a.each{|i|
  ary.push(i["name"] + " " + i["type"])
  #if i["notnull"] then
  #  ary.push(i["name"] + " " + i["type"])
  #end
}
query += ary.join(",")
query += ")"
#
puts query # create table
