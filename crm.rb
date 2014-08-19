require_relative 'contact'
require_relative 'rolodex'
require 'sinatra'

@@rolodex = Rolodex.new


# routes
get '/' do
  @crm_app_name = "Today's CRM"
  erb :index
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do ## implement meeeeeeeee
  puts params
  contact = Contact.new(params['first_name'], params['last_name'], params['email'], params['notes'])
  @@rolodex.add_contact(contact)
  redirect to('/contacts')
end

get '/contacts/new' do
  erb :new_contact
end