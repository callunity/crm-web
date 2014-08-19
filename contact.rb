class Contact
  attr_accessor :id, :first_name, :last_name, :email, :notes

  def initialize(first_name, last_name, email, notes)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @notes = notes
  end

  def to_s
  	"Contact ID: #{@id} \n#{@first_name} \n#{@last_name} \n#{@email} \n#{@notes}"
  end



end