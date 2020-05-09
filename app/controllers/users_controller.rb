class UsersController < ApplicationController
before_action :authenticate_user!
before_action :correct_user, only: [:edit ,:update]
  def index
  	@users =User.all
  	@user = current_user
    @book = Book.new
  end

  def show
  	@user =User.find(params[:id])
    @book = Book.new
    @books = @user.books.page(params[:page]).reverse_order

  end

  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
      redirect_to book_path(@book.id)
      flash[:success] = "Book was successfully created."
    else
      @books =Book.all
      @user = current_user
      render :index
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update

    @user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:success] = "You have updated book successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name,:profile,:profile_image)

  end

  def book_params
        params.require(:book).permit(:title, :body,)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end
end
