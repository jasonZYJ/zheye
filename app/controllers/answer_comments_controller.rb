class AnswerCommentsController < CommentsController
  before_action :get_comment, :only => [:edit]
  authorize_resource
  def get_comment
    @comment = AnswerComment.find(params[:answer_comment_id])
  end
  # Display all comments to an answer
  def index
    @comments = AnswerComment.where(answer_id: params[:answer_id])
  end
  # Action: Create a new comment to answer
  def create
    #@question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    @comment = AnswerComment.new(answer_comment_params)
    @comment.answer = @answer
    #@comment.question = @question
    @comment.user = current_user
    if @comment.save
      redirect_to @comment.answer.question
      flash[:notice] = 'Comment created!'
    else
      render 'comment/new'
      flash[:notice] = 'Failed!'
    end
  end

  # Display an comment box to current answer
  def new
    @comment = AnswerComment.new
    @comment.answer = Answer.find(params[:answer_id])
  end

  # Display form to edit current answer comment
  def edit
  end

  private
  def answer_comment_params
    params.require(:answer_comment).permit(:content)
  end
end
