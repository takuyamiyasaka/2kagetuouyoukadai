class BooksController < ApplicationController
  def edit
  	@book=Book.find(params[:id])
    if @book.user==current_user
    else
      redirect_to books_path
  end
end

  def update
  	@book=Book.find(params[:id])
  	if @book.update(book_params)
  	   redirect_to book_path(@book.id),notice:"You have updated book successfully."
  else
    render :edit
  end
  end

  def index
  	@user=current_user
  	@book=Book.new
  	@books=Book.all
  end

  def show
  	@_book=Book.new
  	@book=Book.find(params[:id])
    @user=@book.user
    @post_comment = PostComment.new
  end
  def create
  	book = Book.new(book_params)
  	book.user_id = current_user.id
  	if book.save
  	   redirect_to book_path(book.id),notice:"You have creatad book successfully."
    else
      @book=book
      @user=current_user
      @books=Book.all
      render :index
  end
end
  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end
