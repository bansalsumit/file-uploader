class AttachmentsController < ApplicationController

  def index
    @attachments = Attachment.where(user_id: current_user.id)
  end

  def new
    @attachment = Attachment.new(user: current_user)
  end

  def create
    @attachment = Attachment.new(permitted_params)
    @attachment.user = current_user
    if @attachment.save
      redirect_to attachments_path, notice: "The file #{@attachment.title} has been uploaded successfully."
    else
      render 'new'
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])

    if @attachment.destroy
      message = "The file #{@attachment.title} deleted successfully."
    else
      message = "The file #{@attachment.title} is not present in our system."
    end
    redirect_to attachments_path, notice: message
  end

  private
    def permitted_params
      params.require(:attachment).permit(:title, :description, :attachment)
    end
end
