require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"

require_relative "database_persistence"

configure do
  set :erb, escape_html: true
end

configure(:development) do
  require "sinatra/reloader"
  also_reload "database_persistence"
end


@db = DatabasePersistence.new

=begin
This is an application that will initially be command line.

Purpose: Create and update goals, habits, and log habits daily.

STEP 1: Create methods that INSERT, UPDATE, DELETE goals

STEP 2: Create methods that INSERT, UPDATE, DELETE habits

STEP 3: Create the interface that allows user to communicate with command line

=end

# Web App Routes

get '/' do
  erb :goals
end


# Terminal Commands

def create_goal
  goal = get_user_answer("What's your goal?")
  insert_success = @db.add_goal(goal)
  if insert_success
    prompt("Goal created!")
  else
    prompt("Error creating goal. This goal may already exist!")
  end
end

def delete_goal
  goal = get_user_answer("Which goal would you like to delete?")
  delete_success = @db.delete_goal(goal)
  if delete_success
    prompt("Goal successfully deleted!")
  else
    prompt("Goal not found.")
  end
end

def edit_goal
  target_goal = get_user_answer("Which goal would you like to edit?")
  new_goal = get_user_answer("What would you like to change the goal to?")
  edit_success = @db.edit_goal(target_goal, new_goal)
  if edit_success
    prompt("Goal successfully edited!")
  else
    prompt("Goal not found.")
  end
end

def list_goals
  goals = @db.get_goals
  prompt("Your goals:")
  goals.each { |goal| prompt("- " + goal) }
end

# Helper Methods

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
  edit_goal
when 'delete_goal'
  delete_goal
when'add_habit'
  create_habit
when 'edit_habit'
  edit_habit
when 'delete_habit'
  delete_habit
when 'list_goals'
  list_goals
when 'list_habits'
  list_habits_for
end