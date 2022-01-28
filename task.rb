require 'pry-byebug'
# Task.new(title: 'new task')
# Task.new('title' => 'new task')

class Task
  attr_reader :title, :description

  def initialize(attributes = {})
    @id = attributes[:id] || attributes['id']
    @title = attributes[:title] || attributes['title']
    @description = attributes[:description] || attributes['description']
    @done = attributes[:done] || attributes['done'] || false
  end

  def self.find(id)
    # ask the database for task with a specific ID
    # we get a hash in return
    query = "SELECT * FROM tasks WHERE id = ?"
    post_hash = DB.execute(query, id).first
    # turn the hash into an instance
    return Task.new(post_hash) if post_hash
  end

  def self.all
    query = "SELECT * FROM tasks"
    post_hashes = DB.execute(query)
    post_hashes.map do |post_hash|
      Task.new(post_hash)
    end
  end

  def save
    @id ? update : create
  end

  def destroy
    query = 'DELETE FROM tasks WHERE id = ?'
    DB.execute(query, @id)
  end

  private

  def update
    query = 'UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?'
    DB.execute(query, @title, @description, @done, @id)
  end

  def create
    query = 'INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)'
    DB.execute(query, @title, @description, @done ? 1 : 0)
    @id = DB.last_insert_row_id
  end
end

# task.save
# Task.find(1) # return an instance or nil
# task = Task.new
# task.title = "new title"
# Task.create(title: "new title") next week
