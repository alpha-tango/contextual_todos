class Todo
  attr_accessor :id, :body, :complete, :category

  def initialize(attributes={})
    @id = attributes['id']
    @body = attributes['body']
    @category = attributes['category']
    @complete = attributes['complete'] || false
  end

  def complete?
    complete == 't'
  end

#NEEDS EDITING
  def save
    sql = 'INSERT INTO todos (body, category, complete) VALUES ($1, $2, $3) RETURNING *'

    Database.exec(sql, [body, category, complete])

    self
  end

  def self.all
    sql = 'SELECT * FROM todos'

    results = Database.exec(sql)

    results.map { |attributes| new(attributes) }
  end

  def self.create(attributes)
    todo = new(attributes)
    todo.save
  end

  def self.categories
    sql = 'SELECT DISTINCT category FROM todos'
    results = Database.exec(sql).to_a.map { |cat| cat["category"]}
  end
end
