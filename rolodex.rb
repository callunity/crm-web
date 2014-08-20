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

  def search(attribute) ## next: regex
    @contacts.each do |contact|
      if contact.id == attribute
        return contact
      elsif contact.first_name == attribute
        return contact
      elsif contact.last_name == attribute
        return contact
      elsif contact.email == attribute
        return contact
      elsif contact.notes == attribute
        return contact
      else puts "Attribute does not match any contacts."
      end
    end

  end

  def search_all(params)
    results = []
    @contacts.each do |contact|
      if contact.first_name.downcase == params["search_term"].downcase
        results << contact
      elsif contact.last_name.downcase == params["search_term"].downcase
        results << contact
      elsif contact.email.downcase == params["search_term"].downcase
        results << contact
      elsif contact.notes.downcase == params["search_term"].downcase
        results << contact
      else puts "Attribute does not match any contacts."
      end
    end
    return results
  end

  def delete_contact(contact_id) 
    @contacts.each do |contact| 
      @contacts.delete(contact) if contact.id == contact_id
    end
  end

end
