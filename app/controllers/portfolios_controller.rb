class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end
  def show
    
  end
  def new

  end
  def create

  end
  def edit

  end
  def update

  end
  def destroy

  end
private
  def set_portfolio
    @portfolio = Portfolio.find params[:id]
  end
end
