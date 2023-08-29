class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  helper_method :star_rating

  def index
    @average_rating = Comment.average_rating
    @comments = if params[:content].present?
                  Comment.by_content(params[:keyword])
                else
                  Comment.all
                end
  end

  def new
    @comment = Comment.new
  end

  def create
    if params[:restaurant_id]
      @commentable = Restaurant.friendly.find(params[:restaurant_id])
    elsif params[:site_id]
      @commentable = Site.friendly.find(params[:site_id])
    elsif params[:hotel_id]
      @commentable = Hotel.friendly.find(params[:hotel_id])
    elsif @commentable = Plan.friendly.find(params.fetch(:plan_id, nil))
    end
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.turbo_stream { redirect_to @commentable, notice: '評論成功 ' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@comment, partial: 'comments/form', locals: { comment: @comment }) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to comments_path, notice: '編輯成功'
    else
      render :edit
    end
  end

  def destroy
    @comment.update(deleted_at: Time.now)
    redirect_to request.referrer, notice: '刪除成功'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :title, :author, :rating, :image, images: [])
  end

  def star_rating(rating)
    stars = ''
    rating.to_i.times { stars += '<i class="fas fa-star" style="color: #ff857;"></i>' }
    (5 - rating.to_i).times { stars += '<i class="fa-solid fa-star" style="color: #effc36;"></i>' }
    stars.html_safe
  end
end
