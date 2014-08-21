class Rolodex
attr_accessor :contacts


  def initialize
	  @contacts = []
    @index = 1000
  end

  def add_contact(contact)
    contact.id = @index
    @contacts << contact
    @index += 1
    contact
  end

  def search(id) ## next: regex
    @contacts.each do |contact|
      if contact.id == id
        return contact
      else puts "Attribute does not match any contacts."
      end
    end

  end

  # def search_old(params)
  #   search_term = params["search_term"].downcase
  #   results = []
  #   @contacts.each do |contact|
  #     if contact.first_name.downcase.include? search_term
  #       results << contact
  #     elsif contact.last_name.downcase.include? search_term
  #       results << contact
  #     elsif contact.email.downcase.include? search_term
  #       results << contact
  #     elsif contact.notes.downcase.include? search_term
  #       results << contact
  #     else puts "Attribute does not match any contacts."
  #     end
  #   end
  #   return results
  # end

  def search_all(params)
    search_term = params["search_term"].downcase
    @contacts.select do |contact|
      [:first_name, :last_name, :email, :notes].each do |method|
        contact.send(method).downcase.include? search_term
      end
    end
  end

  def delete_contact(contact_id) 
    @contacts.each do |contact| 
      @contacts.delete(contact) if contact.id == contact_id
    end
  end

end
