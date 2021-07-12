require 'pg'
require 'pry'

class DatabasePersistence
  def initialize
    @db = PG.connect(dbname: "habits")
  end

  def habits_list
    sql = "SELECT habit FROM habits;"
    result = @db.exec(sql)
  end

  # Inserts goal into goals table. Returns false if goal already exists and true if insertion successful.
  def add_goal(goal)
    sql = "INSERT INTO goals (goal) VALUES ($1)"
    begin
      @db.exec_params(sql, [goal])
    rescue PG::Error
      return false
    end
    true
  end

  # Returns an array of all goals in database
  def get_goals
    sql = "SELECT goal FROM goals"
    result = @db.exec(sql)
    result.values.flatten
  end
end