class FeedbacksController < ApplicationController

  before_action :authenticate_user!, :except => [:new, :create, :thankyou]
  def index
    feedbacks = Feedback.all
    @feedbacks = feedbacks.paginate(page: params[:page]).order("created_at DESC").per_page(5)
      respond_to do |format|
        format.html
        format.csv {send_data @feedbacks.to_csv(['name', 'contact_no', 'socity', 'block', 'flat_number', 'product_feedback', 'executive_feedback'])}
      end
  end

  def new
  	@feedback = Feedback.new
  end

  def create
  	@feedback = Feedback.new(feedback_params)
    respond_to do |format|
      if @feedback.save
        format.json {render json: @feedback, status: :created}
        format.js
        format.html {redirect_to thankyou_path, flash: {success: "Loan was successfully created."}}
        else
        format.json {render json: @feedback.errors.full_messages, status: :unprocessable_entity}
        format.js
        format.html {render "new", flash: {error: @feedback.errors.full_messages}}
        end
    end
  end

  def thankyou
  end

  def edit
    @feedback = Feedback.find(params[:id])
  end

  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update(feedback_params)
      flash[:notice] = "Feedback was Update successfully"
      redirect_to feedbacks_path
      # format.html { redirect_to feedbacks_path, notice: 'Feedback was successfully updated.'}
      # format.json { render :show, status: :ok, location: @feedback }
    else
      format.html { render :edit }
      format.json { render json: @feedback.errors, status: :unprocessable_entity }
    end
  end


  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_path, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def feedback_params
  	params.require(:feedback).permit(:name, :contact, :society, :block, :flat_number, :product_feedback, :executive_feedback, references_attributes: [:id, :contact_no, :_destroy])
  end

end
