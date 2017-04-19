########################################################
# Name:Build DB Util
# Auther:agri
# Date:2017/4/18
########################################################

DATA_PATH = "../../data/"

# TODO not null制約やpKeyの考慮
module CreateDatabase
  def createTableStatement (table)
    query = "CREATE TABLE " + table["table_name"] + "("
    ary_column = []
    table["cols"].each{|i|
      ary_column.push(i["name"] + " " + i["type"])
      #if i["notnull"] then
      #  ary_column.push(i["name"] + " " + i["type"])
      #end
    }
    query += ary_column.join(",")
    query += ")"

    # テーブル作成
    return query
  end

  def importData(csv_path, file_name)
    return "COPY chemicals FROM '" + csv_path + file_name + "' WITH CSV"
  end
end


