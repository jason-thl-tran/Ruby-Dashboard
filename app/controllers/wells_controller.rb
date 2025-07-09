class WellsController < ApplicationController
  before_action :set_well, only: %i[ show edit update destroy ]

  # GET /wells or /wells.json
  def index
    @wells = Well.all

    # Fetch Apple stock data from Alpha Vantage
    response = HTTParty.get('https://www.alphavantage.co/query', query: {
      function: 'TIME_SERIES_DAILY',
      symbol: 'AAPL',
      apikey: '5J58B4IHRIMDCH9E' 
    })

    if response.success?
      @stock_data = parse_stock_data(response)
    else
      @stock_data = []
      flash[:alert] = "Failed to fetch stock data."
    end
  end

  # GET /wells/1 or /wells/1.json
  def show
  end

  # GET /wells/new
  def new
    @well = Well.new
  end

  # GET /wells/1/edit
  def edit
  end

  # POST /wells or /wells.json
  def create
    @well = Well.new(well_params)

    respond_to do |format|
      if @well.save
        format.html { redirect_to @well, notice: "Well was successfully created." }
        format.json { render :show, status: :created, location: @well }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @well.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wells/1 or /wells/1.json
  def update
    respond_to do |format|
      if @well.update(well_params)
        format.html { redirect_to @well, notice: "Well was successfully updated." }
        format.json { render :show, status: :ok, location: @well }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @well.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wells/1 or /wells/1.json
  def destroy
    @well.destroy!

    respond_to do |format|
      format.html { redirect_to wells_path, status: :see_other, notice: "Well was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Parse stock data from Alpha Vantage response
    def parse_stock_data(response)
      time_series = response['Time Series (Daily)']
      return [] unless time_series

      time_series.map do |date, data|
        { date: date, close: data['4. close'].to_f }
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_well
      @well = Well.find(params.require(:id))
    end

    # Only allow a list of trusted parameters through.
    def well_params
      params.require(:well).permit(:name, :state, :md, :tvd, :status)
    end
end
