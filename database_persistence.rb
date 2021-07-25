require 'pg'
require 'pry'

class DatabasePersistence
  GOALS_TBL = "goals"

  def initialize
    @db = PG.connect(dbname: "habits")
    
  end

  # Inserts goal into goals table. Returns false if goal already exists and true if insertion successful.
  def add_goal(goal)
    sql = "INSERT INTO #{GOALS_TBL} (goal) VALUES ($1)"
    begin
      @db.exec_params(sql, [goal])
    rescue PG::Error
      return false
    end
    true
  end

  # Returns an array of all goals in database
  def get_goals
    sql = "SELECT goal FROM #{GOALS_TBL}"
    result = @db.exec(sql)
    result.values.flatten
  end

  # Deletes from 'goals' table. Returns true if goal successfully deleted. Returns false otherwise.
  def delete_goal(goal)
    sql = "DELETE FROM #{GOALS_TBL} WHERE goal = $1"
    result = @db.exec_params(sql, [goal])
    result.cmd_status == "DELETE 1"
  end

  # Edits the target goal if found in the database with the new goal. Returns true if edit sucessful. False otherwise.
  def edit_goal(target_goal, new_goal)
    sql = "UPDATE #{GOALS_TBL} SET goal = $1 WHERE goal = $2"
    result = @db.exec_params(sql, [new_goal, target_goal])
    result.cmd_status == "UPDATE 1"
  end
end