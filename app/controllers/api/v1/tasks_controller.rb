class Api::V1::TasksController < ApplicationController
  before_action :set_api_v1_task, only: %i[ show update destroy ]

  # GET /api/v1/tasks
  def index
    @api_v1_tasks = Api::V1::Task.all

    render json: @api_v1_tasks
  end

  # GET /api/v1/tasks/1
  def show
    render json: @api_v1_task
  end

  # POST /api/v1/tasks
  def create
    @api_v1_task = Api::V1::Task.new(api_v1_task_params)

    if @api_v1_task.save
      render json: @api_v1_task, status: :created, location: @api_v1_task
    else
      render json: @api_v1_task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tasks/1
  def update
    if @api_v1_task.update(api_v1_task_params)
      render json: @api_v1_task
    else
      render json: @api_v1_task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tasks/1
  def destroy
    @api_v1_task.destroy!

    render json: { message: 'Task deleted successfully'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_task
      @api_v1_task = Api::V1::Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_task_params
      params.require(:task).permit([:title, :note, :completed])
    end
end
