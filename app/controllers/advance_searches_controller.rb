class AdvanceSearchesController < ApplicationController
  before_action :set_advance_search, only: [:show, :edit, :update, :destroy]

  # GET /advance_searches
  # GET /advance_searches.json
  def index
    @advance_searches = AdvanceSearch.all
  end

  # GET /advance_searches/1
  # GET /advance_searches/1.json
  def show
    @is_adv_search=params[:advance_search]
  end

  # GET /advance_searches/new
  def new
    @advance_search = AdvanceSearch.new
  end

  # GET /advance_searches/1/edit
  def edit
  end

  # POST /advance_searches
  # POST /advance_searches.json
  def create
    @advance_search = AdvanceSearch.new(advance_search_params)

    respond_to do |format|
      if @advance_search.save
        format.html { redirect_to spendings_url(:id=>@advance_search), notice: 'Advance search was successfully created.' }
        format.json { render action: 'show', status: :created, location: @advance_search }
      else
        format.html { render action: 'new' }
        format.json { render json: @advance_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advance_searches/1
  # PATCH/PUT /advance_searches/1.json
  def update
    respond_to do |format|
      if @advance_search.update(advance_search_params)
        format.html { redirect_to @advance_search, notice: 'Advance search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @advance_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advance_searches/1
  # DELETE /advance_searches/1.json
  def destroy
    @advance_search.destroy
    respond_to do |format|
      format.html { redirect_to advance_searches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advance_search
      @advance_search = AdvanceSearch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advance_search_params
      params.require(:advance_search).permit(:keyword, :start_date, :end_date, :minimum_price, :maximum_price, :hidden_value)
    end
end
