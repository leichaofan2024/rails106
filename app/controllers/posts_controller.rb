class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end
  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user= current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.group = @group
  end
  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to group_path(@group),notice: "更新成功！"
    else
      render :edit
    end
  end
  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to group_path(@group), warning: "删除成功！"
  end
  # def mypost
  #   # @groups = Group.all
  #   @posts = current_user.posts
  # end
  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
