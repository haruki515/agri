########################################################
# Name:Build DB
# Auther:agri
# Date:2017/4/15
########################################################
require 'pg'
require 'yaml'
require './build_util'


T = YAML.load_file('../tables/scheme.yml')
DB_CONF = YAML.load_file('../conf.yml')
CSV_PATH = "../../data/"

# TODO ログを吐けるようにする
class BuildDb
  include CreateDatabase
  def initialize
    db_config = DB_CONF
    @connection = PG.connect(db_config)
    @connection.internal_encoding = 'UTF-8'
    puts "DB(" + db_config["dbname"] +") connected"
  end

  def create_table(table)
    puts "---------------" + "START " + table["table_name"] + "---------------"
    @connection.exec("DROP TABLE IF EXISTS " + table["table_name"])

    # テーブル作成
    puts "Create table " + table["table_name"]
    query = createTableStatement(table)
    @connection.exec(query)
    puts "...Done."

    # import data
    puts "Import data to " + table["file_name"]
    @connection.exec(importData(CSV_PATH, table["file_name"]))
    puts "...Done."
    puts "---------------" + "END " + table["table_name"] + "---------------"
  end
end

## main TODO ループにする
database = BuildDb.new
database.create_table(T["scheme"][0])