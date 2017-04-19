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
CSV_PATH = "/data/csv/"

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
    puts "---------------" + "START " + table["table_name"] + "---------------"
    @connection.exec("DROP TABLE IF EXISTS " + table["table_name"])

    # テーブル作成
    puts "Create table " + table["table_name"]
    query = createTableStatement(table)
    @connection.exec(query)
    puts "...Done."

    # import data
    puts "Import data to " + table["file_name"]
    @connection.exec(importData(CSV_PATH, table["file_name"], table["header"]))
    puts "...Done."
    puts "---------------" + "END " + table["table_name"] + "---------------"
  end
end

## main TODO ループにする
database = BuildDb.new
for target in SEED_LIST do
  database.seed_table(T["schema"][target])
end
