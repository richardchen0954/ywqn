class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @groups = Group.all.order("id DESC").paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.order("id DESC").paginate(:page => params[:page], :per_page => 10)
  end

  def edit
  end

  def update

  if @group.update(group_params)
    redirect_to groups_path, notice: "改好咯～"
  else
    render :edit
  end
  end

    def destroy
      @group.destroy
      flash[:alert] = "删掉咯～"
      redirect_to groups_path
    end

  def new
    @group = Group.new
  end

   def create
     @group = Group.new(group_params)
     @group.user = current_user

     if @group.save
       redirect_to groups_path
     else
       render :new
     end
   end

   private

   def group_params
     params.require(:group).permit(:title, :description)
   end

   def find_group_and_check_permission
     @group = Group.find(params[:id])
     if current_user != @group.user
       redirect_to root_path, alert: "You have no permission."
     end
   end

end
