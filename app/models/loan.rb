class Loan < ApplicationRecord
  
  before_validation :get_id, on: :create


  scope :closed_status, -> { where(:status => 0) }
  scope :opened_status, -> { where(:status => 1) }
  scope :follow_status, -> { where(:status => 2) }

  scope :today, -> { where(:created_at => Date.today)}
  scope :day_wise, -> { where("? BETWEEN startDate AND endDate", Date.today)}

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

#Export and Import Configuration

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |loan|
        csv << loan.attributes.values_at(*fields)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      loan_hash = row.to_hash
      loan = find_or_create_by!(name: loan_hash['name'],contact_no: loan_hash['contact_no'], email: loan_hash['email'], profession: loan_hash['profession'], salary: loan_hash['salary'], obligation: loan_hash['obligation'], status: loan_hash['status'],loan_amount: loan_hash['loan_amount'], remarks: loan_hash['remarks'])
      loan.update_attributes(loan_hash)
    end
  end


end
