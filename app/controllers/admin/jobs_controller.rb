class Admin::JobsController < ApplicationController
  before_action :authenticate_user!,only:[:new,:create,:edit,:update,:destroy]
  before_action :require_is_admin
  layout "admin"
  def index
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
      redirect_to admin_job_path
    else
      render :edit
    end
  end

  def create
      @job=Job.new(job_param)
      if @job.save
        redirect_to admin_job_path
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
      redirect_to admin_job_path
  end

  def publish
    switch_hide_or_publish
  end
  def hide
    switch_hide_or_publish
  end

  private

  def job_param
     params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :company, :is_hidden)
  end

  def switch_hide_or_publish
    @job=Job.find(params[:id])
    @job.is_hidden = !@job.is_hidden
    @job.save
    redirect_to :back
  end

end
