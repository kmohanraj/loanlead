class HousingRentalsController < ApplicationController

  def index
    housings = HousingRental.all
    @housings = housings.paginate(page: params[:page]).order("created_at DESC").per_page(5)
      respond_to do |format|
        format.html
        format.csv {send_data @feedbacks.to_csv(['name', 'contact', 'society_name', 'block', 'flat_no', 'bedroom', 'square_feet', 'rental_amt', 'deposit', 'negotiable', 'site_visit', 'remarks'])}
      end
  end

  def new
  	@housing = HousingRental.new
  end

  def create
  	@housing = HousingRental.new(housing_params)
    respond_to do |format|
      if @housing.save
        format.json {render json: @housing, status: :created}
        format.js
        format.html {redirect_to thank_you_path, flash: {success: "Your rental was successfully updated."}}
        else
        format.json {render json: @housing.errors.full_messages, status: :unprocessable_entity}
        format.js
        format.html {render "new", flash: {error: @housing.errors.full_messages}}
        end
    end
  end

  def edit
    @housing = HousingRental.find(params[:id])
  end

  def show
    @housing = HousingRental.find(params[:id])
  end

  def destroy
    @housing = HousingRental.find(params[:id])
    @housing.destroy
    respond_to do |format|
      format.html { redirect_to housing_rentals_path, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    @housing = HousingRental.find(params[:id])
    if @housing.update(housing_params)
      flash[:notice] = "updated successfully.."
      redirect_to housing_rentals_path
    else
      flash[:notice] = "Something went wrong.."
      render :edit
    end
  end

  def thank_you ;end
end


private

  def housing_params
  	params.require(:housing_rental).permit(:name, :contact, :society_name, :block, :flat_no, :bedroom, :square_feet, :rental_amt, :deposit, :negotiable, :site_visit, :remarks)
  end
