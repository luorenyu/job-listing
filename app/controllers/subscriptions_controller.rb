class SubscriptionsController < ApplicationController
  def index
    flash[:notice]="功能开发中，尽情期待..."
    redirect_to jobs_path
  end

  def new
    flash[:notice]="功能开发中，尽情期待..."
    redirect_to jobs_path
    # @subscription = EmailSubscription.new
    # set_page_title "订阅工作快讯"
  end

  def create
    @subscription = EmailSubscription.new(subscription_params)

    if @subscription.save
      SubscriptionMailer.confirm_email(@subscription).deliver
      redirect_to new_subscription_path , :notice => "感谢您订阅 疯帽子快聘网的工作咨询，我們会发送一封确认邮件到您填写 Email 位址，请注意查收。"
    else
      render :new
    end
  end

  def verify
    @subscription = EmailSubscription.find_by_token(params[:id])

    @subscription.subscribe_to!(Setting.newspaper_email)

    redirect_to root_path , :notice => "您已成功订阅由疯帽子快聘网为您每周推送的最优工作咨询"
  end


  private

  def subscription_params
    params.require(:email_subscription).permit(:email,:name)
  end

end
