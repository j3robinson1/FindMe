class AboutsController < ApplicationController
  def index
    @user = current_user
    if !params[:search].blank?
      @abouts = About.where("name LIKE ?", "%#{params[:search]}%")
    else
      @abouts = @user.abouts
    end
  end 
  def new
    @user = current_user
    @users = User.all
    @about = About.new
  end
  def create
    @users = User.all
    @user = current_user
    @about = @user.abouts.build(about_params)
    if @about.save
      flash[:notice] = 'about was successfully added.'
      redirect_to user_abouts_path(current_user)
    else
      flash[:error] = "Event was NOT added."
      render :new
    end
  end
  def show
    @users = User.all
    @user = current_user
    set_about
  end
  def edit
    @users = User.all
    @user = current_user
    set_about
  end
  def update
    set_about
    @users = User.all
    @about.update_attributes about_params
    if @about.update_attributes about_params
      flash[:notice] = 'about was Successfully saved'
      redirect_to user_abouts_path(current_user)
    else
      flash[:error] = 'about was NOT saved'
      render :edit
    end
  end
  def destroy
    set_about
    @about.destroy
    redirect_to user_abouts_path(current_user)
  end
private
  def set_about
    @about = About.find params[:id]
  end
  def about_params
    params.require(:about).permit(
      :description,
      :user_id
      )
  end
end
