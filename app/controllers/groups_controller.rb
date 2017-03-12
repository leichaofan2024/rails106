class GroupsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :destroy, :update,:people,:join]
  def index
    @groups = Group.all
  end
  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end
  def new
    @group = Group.new
  end
  def create
    @group = Group.new(group_params)
    @group.user = current_user
    current_user.participated_groups << @group
    if @group.save
       redirect_to groups_path
    else
    render :new
    end
 end
 def edit
   @group = Group.find(params[:id])
 end
 def update
   @group = Group.find(params[:id])
   @group.update(group_params)
   redirect_to groups_path, notice: "更新成功！"
 end
 def destroy
   @group = Group.find(params[:id])
   @group.destroy
   redirect_to groups_path,alert: "你已成功删除！"

 end
 def join
   @group = Group.find(params[:id])
   if !current_user.is_member_of?(@group)
     current_user.participated_groups << @group
    #  @group.members << current_user
     redirect_to group_path(@group),alert: "加入成功！"
   elsif current_user.is_member_of?(@group)
     current_user.participated_groups.delete(@group)
    #  @group.members.delete(current_user)
     redirect_to group_path(@group),alert: "退出成功！"
   end

  end
  def groupmember
    @groups = current_user.participated_groups
  end
  def people

    @group = Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      redirect_to group_path(@group)
    end
  end
 private

 def group_params
    params.require(:group).permit(:title,:description)
 end
end
