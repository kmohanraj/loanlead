class Feedback < ApplicationRecord
	has_many :references, dependent: :destroy
	accepts_nested_attributes_for :references, :allow_destroy => true

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |feedback|
        csv << feedback.attributes.values_at(*fields)
      end
    end
  end

end
