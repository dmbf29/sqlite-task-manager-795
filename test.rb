require "sqlite3"
DB = SQLite3::Database.new('tasks.db')
DB.results_as_hash = true
require_relative 'task'

# TODO: CRUD some tasks
task = Task.find(1) # this should return an instance
puts "#{task.title} - #{task.description}"
task.save

# title = @view.ask_for('title')
# task.title = "New title"

task = Task.new(title: 'Finish Livecode!', description: "Relax this weekend")
task.save
p task



# p Task.all
