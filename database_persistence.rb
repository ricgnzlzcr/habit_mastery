require 'pg'
require 'pry'

class DatabasePersistence
  def initialize
    @db = PG.connect(dbname: "habits")
  end

  def habits_list
    sql = "SELECT habit FROM habits;"
    result = @db.exec(sql)
    binding.pry
  end
end