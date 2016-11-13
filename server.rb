require 'sinatra'
require 'pry'
require 'csv'

get '/' do
  redirect '/groceries'
end

get '/groceries' do
  @groceries = CSV.readlines('grocery_list.csv', headers: true)
  erb :index
end

post '/groceries' do
  @num = params[:quantity]
  grocery = params[:Name]
  if grocery.empty?
    @groceries = CSV.readlines('grocery_list.csv', headers: true)
    @error = 'Please supply an Item'
    erb :index
  else
    CSV.open('grocery_list.csv', 'a') do |file|
      file << [grocery, @num]
    end
    redirect '/groceries'
  end
end

get '/groceries/:item' do
  item_array = params[:item].split('-')
  @item_name = item_array[0]
  @print_num = item_array[1]
  erb :item
end
