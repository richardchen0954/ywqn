class PostsController < ApplicationController

 before_action :authenticate_user!, :only => [:new, :create, :destroy]

 def create
   @group = Group.find(params[:group_id])
   @post = Post.new(post_params)
   @post.group = @group
   @post.user = current_user
   @post.save
 end

    def destroy
      @group = Group.find(params[:group_id])
      @post = current_user.posts.find(params[:id]) # 只能删除自己的贴文
      @post.destroy

    end
      def like
   @group = Group.find(params[:group_id])
        @post = Post.find(params[:id])
        unless @post.find_like(current_user)  # 如果已经按讚过了，就略过不再新增
          Like.create( :user => current_user, :post => @post)
        end
      end

      def unlike
        @group = Group.find(params[:group_id])
        @post = Post.find(params[:id])
        like = @post.find_like(current_user)
        like.destroy
        render "like"
      end


 private

 def post_params
   params.require(:post).permit(:content)
 end

end
