class Database
  def self.exec(sql, params=[])
    connection = PG.connect(dbname: 'sinatra_jquery_todos')
    connection.exec(sql, params)
  ensure
    connection.close
  end
end
