########################################################
# Name:Build DB Util
# Auther:agri
# Date:2017/4/18
########################################################

DATA_PATH = "../../data/"

module CreateDatabase
  def createTableStatement (table)
    query = "CREATE TABLE "
    query += table["table_name"]
    query += "("
    
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
    connection.exec(query)
  end

  def importData
    return "COPY chemical FROM '/home/vagrant/repos/agri/worker/data/chemicals.csv' WITH CSV"
  end
end


