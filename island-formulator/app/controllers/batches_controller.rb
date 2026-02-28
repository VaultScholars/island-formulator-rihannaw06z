class BatchesController < ApplicationController
  before_action :require_authentication
  before_action :set_batch, only: %i[ show edit update destroy ]

  # GET /batches or /batches.json
  def index
    @batches = current_user.batches.includes(:recipe).order(made_on: :desc)
  end

  # GET /batches/1 or /batches/1.json
  def show
    @batch = current_user.batches.find(params[:id])
  end

  # GET /batches/new
  def new
    @batch = current_user.batches.build(recipe_id: params[:recipe_id], made_on: Date.today)
  end

  # GET /batches/1/edit
  def edit
  end

  # POST /batches or /batches.json
  def create
    @batch = current_user.batches.build(batch_params)


    if @batch.save
      redirect_to batches_path, notice: "Batch was successfully logged."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def batch_params
      params.require(:batch).permit(:recipe_id, :made_on, :notes)
    end
end
