require 'minitest/autorun'

require_relative 'database_persistence'

class DatabasePersistenceTest < Minitest::Test
  def setup
    @db = DatabasePersistence.new
    @db.add_goal("test goal")
  end

  def test_add_goal
    goals = @db.get_goals
    assert_includes(goals, "test goal")

    # Check that can't add duplicate goal
    refute(@db.add_goal("test goal"))
  end

  def test_delete_goal
    assert_equal(false, @db.delete_goal("lklaknsldfn"))
    
  end

  def teardown
    @db.delete_goal("test goal")
  end
end