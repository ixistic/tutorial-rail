class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]
  load_and_authorize_resource

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
    @book = Book.new
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    if(book_params[:publisher_id] == '-1')
      @publisher = Publisher.create(name:params[:publisher_name])
      params[:book][:publisher_id] = @publisher.id
    end

    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        @authors = params[:book][:author_ids]
        @authors.each do |author|
          if author > '0'
            Authorship.create(book_id:@book.id, author_id:author)
          end
        end
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if(book_params[:publisher_id] == -1)
      @publisher = Publisher.create(name:params[:publisher_name])
      params[:book][:publisher_id] = @publisher.id
    end

    respond_to do |format|
      if @book.update(book_params)
        @authors = params[:book][:author_ids]
        Authorship.destroy_all(book_id:@book.id)
        @authors.each do |author|
          Authorship.create(book_id:@book.id, author_id:author)
        end
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :published_date, :publisher_id)
    end
end
