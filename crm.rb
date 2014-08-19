require_relative 'contact'
require_relative 'rolodex'
require 'sinatra'

@@rolodex = Rolodex.new

@@rolodex.add_contact(Contact.new("Heather", "Armstrong", "hea@ther.com", "tester"))
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

get '/contacts/:id' do
  @contact = @@rolodex.search(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

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

delete '/contacts/:id' do
  @contact = @@rolodex.search(params[:id].to_i)
  if @contact
    @@rolodex.delete_contact(@contact)

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/edit' do
  @contact = @@rolodex.search(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

