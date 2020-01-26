class PostCommentsController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		comment = current_user.post_comments.new(post_comment_params)
		comment.book_id = book.id
		comment.save
		redirect_to book_path(book)
	end
	def destroy
		book =Book.find(params[:book_id])
		comment = PostComment.find(params[:id])
		if comment.user.id == current_user.id
			comment.destroy
			redirect_to book_path(book)
		else
			redirect_to book_path(book)
		end
	end
	private
	def post_comment_params
		params.require(:post_comment).permit(:user_id,:book_id,:comment)
	end
end
