class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]
  
  # after_action :get_id, on: :create

  def index
    loans = Loan.search(params[:search])
    loans = Loan.closed_status if params[:search] == "closed_status"
    loans = Loan.opened_status if params[:search] == "opened_status"
    loans = Loan.follow_status if params[:search] == "follow_status"
    loans = Loan.day_wise if params[:search] == "day_wise"
    loans = Loan.all if params[:search].nil?
    @loans = loans.paginate(page: params[:page]).order("created_at DESC").per_page(10)
    respond_to do |format|
    format.html
    format.json {render json: @loan, status: :ok}
    end 
  end

  def new
    @loan = Loan.new
  end

  def create
    user_id = current_user.id
    @loan_created = Loan.new(name: params[:loan][:name],
     contact_no: params[:loan][:contact_no], email: params[:loan][:email],
      loan_amount: params[:loan][:loan_amount],
       status: params[:status].to_i, profession: params[:loan][:profession],
        salary: params[:loan][:salary], remarks: params[:loan][:remarks],
         obligation: params[:loan][:obligation], loan_amount: params[:loan][:loan_amount])
    @loan_created.user_id = user_id
    respond_to do |format|
      if @loan_created.save
      format.json {render json: @loan_created, status: :created}
      format.js
      format.html {redirect_to root_path, flash: {success: "Loan was successfully created."}}
      else
      format.json {render json: @loan_created.errors.full_messages, status: :unprocessable_entity}
      format.js
      format.html {redirect_to loans_path, flash: {error: @loan_created.errors.full_messages}}
      end
    end
  end


  def show
  end

  def edit
    @loan  = Loan.find(params[:id])
  end

  def update
    respond_to do |format|
      if @loan.update(name: params[:loan][:name],
     contact_no: params[:loan][:contact_no], email: params[:loan][:email],
      loan_amount: params[:loan][:loan_amount],
       status: params[:status].to_i, profession: params[:loan][:profession],
        salary: params[:loan][:salary], remarks: params[:loan][:remarks],
         obligation: params[:loan][:obligation], loan_amount: params[:loan][:loan_amount])
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_loan
      @loan = Loan.find(params[:id])
    end

    def loan_params
      params.require(:loan).permit(:name, :contact_no, :email, :loan_amount, :pstatus, :profession, :salary, :remarks, :obligation)
    end


    def get_id
      # @id = Loan.all
      # @loan_id = @id.ids.last
      # p @loan_id
      self.reference =  "FYL/000" if self.reference.blank?

    end

end
