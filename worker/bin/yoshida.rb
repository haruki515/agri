########################################################
# Name:Build DB
# Auther:agri
# Date:2017/4/15
########################################################
require 'pg'
require 'yaml'
require './build_util'


T = YAML.load_file('../tables/scheme.yml')
DB_CONF = YAML.load_file('../conf.yml')["database"]
SEED_LIST = YAML.load_file('../conf.yml')["seed"]
BUILD_LIST = YAML.load_file('../conf.yml')["build"]
CSV_PATH = "/data/worker/data/"
SQL_PATH = "/data/worker/tables/build/"

# TODO ログを吐けるようにする
class BuildDb
  include CreateDatabase
  def initialize
    db_config = DB_CONF
    @connection = PG.connect(db_config)
    @connection.internal_encoding = 'UTF-8'
    puts "DB(" + db_config["dbname"] +") connected"
  end

  def seed_table(table)
    puts "START " + table["table_name"]
    @connection.exec("DROP TABLE IF EXISTS " + table["table_name"])

    # テーブル作成
    query = createTableStatement(table)
    @connection.exec(query)

    # import data
    puts importData(CSV_PATH, table["file_name"], table["header"])
    @connection.exec(importData(CSV_PATH, table["file_name"], table["header"]))
    puts "END " + table["table_name"]
  end

  def build_table(sql_path, sql)
    puts "START " + sql
    @connection.exec(getSql(sql_path + sql))
    puts "END " + sql
  end
end

database = BuildDb.new
# テーブル作成 & テーブルに生データimport
puts "=============================================="
puts "                  START SEED                  "
puts "=============================================="
for target in SEED_LIST do
  database.seed_table(T["schema"][target])
end
puts "=============================================="
puts "                  END SEED                  "
puts "=============================================="
puts "=============================================="
puts "                  START BUILD                 "
puts "=============================================="
## 生テーブルから検索テーブル作成
for sql in BUILD_LIST do
  database.build_table(SQL_PATH, sql)
end
puts "=============================================="
puts "                  END BUILD                 "
puts "=============================================="
