require 'pg'
require 'pry'

class DatabasePersistence
  def initialize
    @db = PG.connect(dbname: "habits")
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

  # Deletes from 'goals' table. Returns true if goal successfully deleted. Returns false otherwise.
  def delete_goal(goal)
    sql = "DELETE FROM goals WHERE goal = $1"
    result = @db.exec_params(sql, [goal])
    result.cmd_status == "DELETE 1"
  end
end