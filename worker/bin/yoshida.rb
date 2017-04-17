########################################################
# Name:Build DB
# Auther:agri
# Date:2017/4/15
########################################################
require 'pg'
require 'yaml'
require './build_util'


T = YAML.load_file('../tables/scheme.yml')

class BuildDb
  include CreateDatabase
  def initialize
    db_conig = {
      host:     '127.0.0.1',
      user:     'agri',
      password: '',
      dbname:   'agri',
      port:     '5432'
    }
    @connection = PG.connect(db_conig)
    @connection.internal_encoding = 'UTF-8'
  end

  def create_table(table)
    @connection.exec("DROP TABLE IF EXISTS " + table["table_name"])
    # テーブル作成
    query = createTableStatement(table)
    @connection.exec(query)
    # import data
    @connection.exec(importData())
  end
end

database = BuildDb.new
database.create_table(T["scheme"][0])
