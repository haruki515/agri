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

  def importData(csv_path, file_name, header)
    return "COPY chemicals FROM '" + csv_path + file_name + "' WITH CSV " + header
  end

  def getSql(file_path)
    begin
      File.open(file_path + ".sql") do |file|
        ret = []
        file.read.split("\n").each do |labmen|
           ret.push(labmen)
        end
        return ret.join(" ")
      end
    rescue SystemCallError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
    rescue IOError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
    end
  end
end


