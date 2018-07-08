json.extract! loan, :id, :name, :contact_no, :email, :loan_amount, :pstatus, :profession, :salary, :remarks, :obligation, :created_at, :updated_at
json.url loan_url(loan, format: :json)
