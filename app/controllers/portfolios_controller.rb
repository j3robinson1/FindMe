class PortfoliosController < ApplicationController
  def index
    @user = current_user
    if !params[:search].blank?
      @portfolios = Portfolio.where("name LIKE ?", "%#{params[:search]}%")
    else
      @portfolios = @user.portfolios
    end
  end 
  def new
    @user = current_user
    @users = User.all
    @portfolio = Portfolio.new
  end
  def create
    @users = User.all
    @user = current_user
    @portfolio = @user.portfolios.build(portfolio_params)
    if @portfolio.save
      flash[:notice] = 'portfolio was successfully added.'
      redirect_to user_portfolios_path(current_user)
    else
      flash[:error] = "Event was NOT added."
      render :new
    end
  end
  def show
    @users = User.all
    @user = current_user
    set_portfolio
  end
  def edit
    @users = User.all
    @user = current_user
    set_portfolio
  end
  def update
    set_portfolio
    @users = User.all
    @portfolio.update_attributes portfolio_params
    if @portfolio.update_attributes portfolio_params
      flash[:notice] = 'portfolio was Successfully saved'
      redirect_to user_portfolios_path(current_user)
    else
      flash[:error] = 'portfolio was NOT saved'
      render :edit
    end
  end
  def destroy
    set_portfolio
    @portfolio.destroy
    redirect_to user_portfolios_path(current_user)
  end
private
  def set_portfolio
    @portfolio = Portfolio.find params[:id]
  end
  def portfolio_params
    params.require(:portfolio).permit(
      :name,
      :description,
      :user_id
      )
  end
end
