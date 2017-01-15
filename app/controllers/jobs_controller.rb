class JobsController < ApplicationController
  before_action :authenticate_user!,only:[:new,:create,:edit,:update,:destroy]
  before_action :validate_search_key,only:[:search]

  def index
    @jobs=Job.where(:is_hidden=>false).order("created_at DESC")
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
        redirect_to job_path(@job)
      else
        render :new
      end
  end

  def show
    @job=Job.find(params[:id])
    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
    redirect_to root_path
  end
  end

  def destroy
      @job=Job.find(params[:id])
      @job.destroy
      redirect_to job_path
  end

  def search
    if @query_string.present?
      search_result = Job.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 20 )
      # set_page_title "搜尋 #{@query_string}"
    end
  end

  private
  def job_param
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :company, :is_hidden)
  end

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    # @search_criteria = search_criteria(@query_string)
  end
end
