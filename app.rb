require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "SQLite3"

def get_db
  return SQLite3::Database.new "barbershop.db"
end

configure do
  db = get_db
  db.execute "CREATE TABLE IF NOT EXISTS Users (
    'id' INTEGER PRIMARY KEY AUTOINCREMENT, 
    'username' TEXT, 
    'phone' TEXT, 
    'datestamp' TEXT, 
    'barber' TEXT
    );"
end

get '/' do
  erb 'Can you handle a <a href="/secure/place">secret</a>?'
end


get "/about" do
  erb :about
end

get "/visit" do
  erb :visit
end

post "/visit" do
  @username = params[:username]
  @phone = params[:phone]
  @dateandtime = params[:dateandtime]
  @barber = params[:barber]

  hh = {:username => "Введите имя", :phone => "Введите телефон", :dateandtime => "Введите дату и время"}
  @error = hh.select {|key,_| params[key] == ""}.values.join("; ")
  if @error != ""
    return erb :visit
  end

  db = get_db
  db.execute "INSERT INTO Users (username, phone, datestamp, barber) values (?,?,?,?)", [@username, @phone, @datetime, @barber]

  erb :visit
end

get "/contacts" do
  erb :contacts
end

get "/showusers" do
  db = get_db

  @results = db.execute "select * from Users order by id desc"
  
  erb :showusers
end

