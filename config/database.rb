configure :test do
  set :database, {
    adapter:  'postgresql',
    encoding: 'utf8',
    database: 'bitchatbot_test',
    pool: 5,
    username: 'postgres',
    host:     'postgres'
  }
end

configure :development do
  set :database, {
    adapter:  'postgresql',
    encoding: 'utf8',
    database: 'bitchatbot_development',
    pool: 5,
    username: 'postgres',
    host:     'postgres'
  }
end

configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///postgres/bitchatbot_production')

  set :database, {
    adapter:  'postgresql',
    host:     db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  }
end
