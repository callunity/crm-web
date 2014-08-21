require_relative 'rolodex'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :notes, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

@@rolodex = Rolodex.new


# routes

# GET request to DISPLAY HOME
get '/' do
  @crm_app_name = "Today's CRM"
  erb :index, :layout => :layout
end

# GET request to DISPLAY ALL contacts
get '/contacts' do
  @contacts = Contact.all
  erb :contacts, :layout => :layout
end

# GET request to create a NEW CONTACT
get '/contacts/new' do
  erb :new_contact, :layout => :layout
end

# POST response for NEW CONTACT
post '/contacts' do 
  puts params
  contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :notes => params[:notes]
    )
  redirect to('/contacts')
end


get '/contacts/search' do
  if params[:search_term]                     ## why do it this way instead of as a post? What are the implications?
    @contacts = @@rolodex.search_all(params)
    erb :contacts, :layout => :layout
  else
    erb :search_contacts, :layout => :layout
  end
  
end

post '/contacts/search' do
  puts params
  @contacts = @@rolodex.search_all(params)
  erb :contacts, :layout => :layout
end

# GET request to DISPLAY ONE contact [form for DELETE, link to EDIT]
get '/contacts/:id' do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact, :layout => :layout
  else
    raise Sinatra::NotFound
  end
end

# GET request to EDIT one contact 
get '/contacts/:id/edit' do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit_contact, :layout => :layout
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





