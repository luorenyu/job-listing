class WelcomeController < ApplicationController
  def index
    flash[:notice]="we need you!"
  end
end
