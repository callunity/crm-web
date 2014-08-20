require_relative 'contact'
require_relative 'rolodex'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

@@rolodex = Rolodex.new


# routes

# GET request to DISPLAY HOME
get '/' do
  @crm_app_name = "Today's CRM"
  erb :index
end

# GET request to DISPLAY ALL contacts
get '/contacts' do
  @contacts = @@rolodex.contacts
  erb :contacts
end

# GET request to create a NEW CONTACT
get '/contacts/new' do
  erb :new_contact
end

# POST response for NEW CONTACT
post '/contacts' do 
  puts params
  contact = Contact.new(params['first_name'], params['last_name'], params['email'], params['notes'])
  @@rolodex.add_contact(contact)
  redirect to('/contacts')
end

get '/contacts/search' do
  erb :search_contacts
end

post '/contacts/search' do
  puts params
  @contacts = @@rolodex.search(params)
  erb :contacts
end

# GET request to DISPLAY ONE contact [form for DELETE, link to EDIT]
get '/contacts/:id' do
  @contact = @@rolodex.search(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

# GET request to EDIT one contact 
get '/contacts/:id/edit' do
  @contact = @@rolodex.search(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

# PUT response to EDIT one contact
put '/contacts/:id' do
  @contact = @@rolodex.search(params[:id].to_i) ## use this code to refactor previous CRM iteration?
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.notes = params[:notes]

    redirect to('/contacts')
  else 
    raise Sinatra::NotFound
  end
end

# DELETE response for one contact
delete '/contacts/:id' do
  @contact = @@rolodex.search(params[:id].to_i)
  if @contact
    @@rolodex.delete_contact(@contact.id)

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end





