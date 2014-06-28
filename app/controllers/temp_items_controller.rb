class TempItemsController < ApplicationController
  before_action :set_temp_item, only: [:show, :edit, :update, :destroy]

  # GET /temp_items
  # GET /temp_items.json
  def index
    @temp_items = TempItem.all
  end

  # GET /temp_items/1
  # GET /temp_items/1.json
  def show
  end

  # GET /temp_items/new
  def new
    @temp_item = TempItem.new
  end

  # GET /temp_items/1/edit
  def edit
  end

  # POST /temp_items
  # POST /temp_items.json
  def create
    @temp_item = TempItem.new(temp_item_params)

    respond_to do |format|
      if @temp_item.save
        format.html { redirect_to @temp_item, notice: 'Temp item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @temp_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @temp_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temp_items/1
  # PATCH/PUT /temp_items/1.json
  def update
    respond_to do |format|
      if @temp_item.update(temp_item_params)
        format.html { redirect_to @temp_item, notice: 'Temp item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @temp_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_items/1
  # DELETE /temp_items/1.json
  def destroy
    @temp_item.destroy if @temp_item.id==session[:temp_item_id]
    session[:temp_item_id]=nil
    respond_to do |format|
      format.html { redirect_to temp_items_url, notice:"Your last planning session was canceled"}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_item
      @temp_item = TempItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def temp_item_params
      params[:temp_item]
      params.require(:finance_item).permit(:goal_id, :temp_item_id)
    end
end
