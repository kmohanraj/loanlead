class Loan < ApplicationRecord
  
  before_validation :get_id, on: :create


  scope :closed_status, -> { where(:status => 0) }
  scope :opened_status, -> { where(:status => 1) }
  scope :follow_status, -> { where(:status => 2) }

  scope :today, -> { where(:created_at => Date.today)}
  scope :day_wise, -> { where("? BETWEEN startDate AND endDate", Date.today)}

  # enum status: [:incomes, :expenses]
	# ENUM_ENTITY = {"incomes" => 0, "expenses" => 1}

  enum status: [:closed, :opened, :follow_up]
  ENUM_ENTITY = {"closed" => 0, "opened" => 1, "follow up" => 2}
 
  def self.search(search)
  	where('name LIKE :search OR email LIKE :search OR contact_no LIKE :search OR reference LIKE :search', search: "%#{search}%")
  end

  def get_id
    @id = Loan.all
    @last =  @id.ids.last
    if @last.nil?
      a = 1
	  self.reference =  "FYL000#{a}" if self.reference.blank?
    else
      a = @last + 1 
      self.reference =  "FYL000#{a}" if self.reference.blank?
    end
  end

end
