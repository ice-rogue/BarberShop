require 'rubygems'
require 'sinatra'
require "sinatra/reloader"

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

  f = File.open("public/users.txt", "a")
  f.write "Имя: #{@username}. Телефон: #{@phone}. Время и дата: #{@dateandtime}. Парикмахер: #{@barber}\n"
  f.close
  erb :visit
end




get "/contacts" do
  erb :contacts
end
