class ResumesController < ApplicationControllerclass resumesController < ApplicationController
  def index
    @user = current_user
    if !params[:search].blank?
      @resumes = Resume.where("name LIKE ?", "%#{params[:search]}%")
    else
      @resumes = @user.resumes
    end
  end 
  def new
    @user = current_user
    @users = User.all
    @resume = Resume.new
  end
  def create
    @users = User.all
    @user = current_user
    @resume = @user.resumes.build(resume_params)
    if @resume.save
      flash[:notice] = 'resume was successfully added.'
      redirect_to user_resumes_path(current_user)
    else
      flash[:error] = "Event was NOT added."
      render :new
    end
  end
  def show
    @users = User.all
    @user = current_user
    set_resume
  end
  def edit
    @users = User.all
    @user = current_user
    set_resume
  end
  def update
    set_resume
    @users = User.all
    @resume.update_attributes resume_params
    if @resume.update_attributes resume_params
      flash[:notice] = 'resume was Successfully saved'
      redirect_to user_resumes_path(current_user)
    else
      flash[:error] = 'resume was NOT saved'
      render :edit
    end
  end
  def destroy
    set_resume
    @resume.destroy
    redirect_to user_resumes_path(current_user)
  end
private
  def set_resume
    @resume = Resume.find params[:id]
  end
  def resume_params
    params.require(:resume).permit(
      :title,
      :start_date,
      :end_date,
      :description,
      :user_id
      )
  end
end
