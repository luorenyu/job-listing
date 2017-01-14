class JobsController < ApplicationController
  before_action :authenticate_user!,only:[:new,:create,:edit,:update,:destroy]

  def index
    flash[:notice]="welcome Hatter website"
    @jobs=Job.all
  end

  def new
      @job=Job.new
  end

  def edit
    @job=Job.find(params[:id])
  end

  def update
    @job=Job.find(params[:id])

    if @job.update(job_param)
      redirect_to job_path
    else
      render :edit
    end
  end

  def create
      @job=Job.new(job_param)
      if @job.save
        redirect_to job_path
      else
        render :new
      end
  end

  def show
    @job=Job.find(params[:id])
  end

  def destroy
      @job=Job.find(params[:id])
      @job.destroy
      redirect_to job_path
  end

  private
  def job_param
    params.require(:job).permit(:title,:description)
  end
end
