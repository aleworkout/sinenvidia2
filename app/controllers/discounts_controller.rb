class DiscountsController < ApplicationController
  before_action :set_discount, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_admin, only: [:create, :edit, :destroy, :new]
  
  # GET /discounts
  # GET /discounts.json
  def index
    @q = Discount.ransack(params[:q])
    @discounts = @q.result(distinct: true)
  end
  
  # GET /discounts/1
  # GET /discounts/1.json
  def show
  end

  # GET /discounts/new
  def new
    @discount = Discount.new
  end
  
  # GET /discounts/1/edit
  
  def edit
  end

  # POST /discounts
  # POST /discounts.json
  
  def create
    @discount = Discount.new(discount_params)

    respond_to do |format|
      if @discount.save
        format.html { redirect_to @discount, notice: 'Discount was successfully created.' }
        format.json { render :show, status: :created, location: @discount }
      else
        format.html { render :new }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # This should probably be abstracted to ApplicationController
  # as shown by diego.greyrobot

  # PATCH/PUT /discounts/1
  # PATCH/PUT /discounts/1.json
  def update
    respond_to do |format|
      if @discount.update(discount_params)
        format.html { redirect_to @discount, notice: 'Discount was successfully updated.' }
        format.json { render :show, status: :ok, location: @discount }
      else
        format.html { render :edit }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discounts/1
  # DELETE /discounts/1.json
  def destroy
    @discount.destroy
    respond_to do |format|
      format.html { redirect_to discounts_url, notice: 'Discount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount
      @discount = Discount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discount_params
      params.require(:discount).permit(:title, :price, :detail, :discount_image, :final_price)
    end
    
    def authorize_admin
      if not signed_in?
        redirect_to root_path
      end  
    end
end
