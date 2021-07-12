=begin
require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"
=end

require_relative "database_persistence"

@db = DatabasePersistence.new

=begin
This is an application that will initially be command line.

Purpose: Create and update goals, habits, and log habits daily.

STEP 1: Create methods that INSERT, UPDATE, DELETE goals

STEP 2: Create methods that INSERT, UPDATE, DELETE habits

STEP 3: Create the interface that allows user to communicate with command line

=end



def create_goal
  goal = get_user_answer("What's your goal?")
  insert_success = @db.add_goal(goal)
  if insert_success
    prompt("Goal created!")
  else
    prompt("Error creating goal. This goal may already exist!")
  end
end

def list_goals
  goals = @db.get_goals
  prompt("Your goals:")
  goals.each { |goal| prompt("- " + goal) }
end

def get_user_answer(question)
  answer = ''
  loop do
    prompt(question)
    answer = gets.chomp
    break unless answer == ''  
    prompt("Not a valid answer")
  end
  answer
end

def prompt(text)
  puts ">> " + text
end



command = ARGV.shift

case command
when 'create_goal'
  create_goal
when 'edit_goal'
  edit_goal(ARGV[0], ARGV[1])
when 'delete_goal'
  delete_goal(ARGV[0])
when'add_habit'
  create_habit(ARGV[0])
when 'edit_habit'
  edit_habit(ARGV[0])
when 'delete_habit'
  delete_habit(ARGV[0])
when 'list_goals'
  list_goals
when 'list_habits'
  list_habits_for(goal)
end