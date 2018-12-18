class PostsController < ApplicationController

 before_action :authenticate_user!, :only => [:new, :create, :destroy]

 def new
   @group = Group.find(params[:group_id])
   @post = Post.new
 end

 def create
   @group = Group.find(params[:group_id])
   @post = Post.new(post_params)
   @post.group = @group
   @post.user = current_user

   if @post.save
     redirect_to group_path(@group)
   else
     render :new
   end
 end

    def destroy
      @group = Group.find(params[:id])
      @post = current_user.posts.find(params[:group_id]) # 只能删除自己的贴文
      @post.destroy

    end
      def like
   @group = Group.find(params[:id])
        @post = Post.find(params[:group_id])
        unless @post.find_like(current_user)  # 如果已经按讚过了，就略过不再新增
          Like.create( :user => current_user, :post => @post)
        end

        redirect_to group_path(@group)
      end

      def unlike
        @group = Group.find(params[:id])
        @post = Post.find(params[:group_id])
        like = @post.find_like(current_user)
        like.destroy

        redirect_to group_path(@group)
      end


 private

 def post_params
   params.require(:post).permit(:content)
 end

end
