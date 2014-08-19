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

  def search(contact_id)
    @contacts.select do |contact|
      return contact if contact.id == contact_id

    end
  end

  def search_all(attribute) ## next: regex
    @contacts.select do |contact|
      if contact.id == attribute 
        puts contact
      elsif contact.first_name == attribute
        puts contact
      elsif contact.last_name == attribute
        puts contact
      elsif contact.email == attribute
        puts contact
      elsif contact.notes == attribute
        puts contact
      else puts "Attribute does not match any contacts."
      end
    end
  end

  def display_info_by_attribute(attribute) ## still not working
    case attribute
    when 1
      sorted = @contacts.sort_by do |contact|
        contact.id.downcase
      end
      sorted.each do |contact|
        puts contact.id
      end
    when 2
      sorted = @contacts.sort_by do |contact|
        contact.first_name.downcase
      end
      sorted.each do |contact|
        puts contact.first_name
      end
    when 3
      sorted = @contacts.sort_by do |contact|
        contact.last_name.downcase
      end
      sorted.each do |contact|
        puts contact.last_name
      end
    when 4
      sorted = @contacts.sort_by do |contact|
        contact.email.downcase
      end
      sorted.each do |contact|
        puts contact.email
      end
    when 5
      sorted = @contacts.sort_by do |contact|
        contact.notes.downcase
      end
      sorted.each do |contact|
        puts contact.notes
      end
    else
      return
    end
  end

  def modify_contact(contact)
    contact_attr_to_modify = gets.chomp.to_i
    puts ""
    case contact_attr_to_modify
    when 1
      puts "Enter new first name"
      new_first_name = gets.chomp
      contact.first_name = new_first_name
    when 2
      puts "Enter new last name"
      new_last_name = gets.chomp
      contact.last_name = new_last_name
    when 3
      puts "Enter new email"
      new_email = gets.chomp
      contact.email = new_email
    when 4
      puts "Enter new note"
      new_notes = gets.chomp
      contact.notes = new_notes
    when 5 
      return
    else puts "Sorry, that is not an option."
    end
  end

  def display_particular_contact(contact_id)
    @contacts.map do |contact|
      puts contact if contact.id == contact_id
    end
  end

  def display_all_contacts
    @contacts.map do |contact|
      puts contact
      puts
    end
  end

  def delete_contact(contact_id) 
    @contacts.map do |contact| 
      if contact.id ==(contact_id.to_i) 
        puts "Are you sure you wish to delete \n#{contact.to_s} \n(yes/no)"
        confirm = gets.chomp
        return unless confirm == "yes"
        @contacts.delete(contact)
        puts "Deleted contact: \n#{contact.to_s}"
      else 
      end
    end
  end

end
