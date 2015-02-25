class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET user/user_id/posts
  # GET user/user_id/posts.json
  def index
    @user = current_user
    @users = User.all
    @posts = Post.all
  end

  # GET user/user_id/posts/1
  # GET user/user_id/posts/1.json
  def show
    @user = current_user
    @users = User.all
    @posts = @user.posts
   @post_attachments = @post.post_attachments.all
end

def new
  @user = current_user
  @users = User.all
  @post = Post.new
  @post_attachment = @post.post_attachments.build
end

def create
   @user = current_user
   @users = User.all
   @post = @user.posts.create!(post_params)

   respond_to do |format|
     if @post.save
       params[:post_attachments]['avatar'].each do |a|
          @post_attachment = @post.post_attachments.create!(:avatar => a, :post_id => @post.id)
         end
       format.html { redirect_to user_posts_path(@user), notice: 'Post was successfully created.' }
     else
       format.html { render action: 'new' }
     end
   end
end

  # PATCH/PUT user/user_id/posts/1
  # PATCH/PUT user/user_id/posts/1.json
  def update
    @users = User.all
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE user/user_id/posts/1
  # DELETE user/user_id/posts/1.json
  def destroy

    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    private
   def post_params
      params.require(:post).permit(:title, post_attachments_attributes: [:id, :post_id, :avatar])
   end
end
