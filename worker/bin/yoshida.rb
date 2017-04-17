########################################################
# Name:Build DB
# Auther:agri
# Date:2017/4/15
########################################################
require 'pg'
require 'yaml'
require '../build_util'

include CreateDatabase

Class BuildDb
  def initialize(siteData)
    T = YAML.load_file('../tables/scheme.yml')
    db_conig = {
      host:     '127.0.0.1',
      user:     'agri',
      password: '',
      dbname:   'agri',
      port:     '5432'
    }
    @connection = PG.connect(db_conig)
    connection.internal_encoding = 'UTF-8'
    puts 'DBconnect'
  end
  def create_table
  end
  def import_data
  end
end
