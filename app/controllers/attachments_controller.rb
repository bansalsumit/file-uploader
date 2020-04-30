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
    @attachment.link = LINK_PREFFIX + current_user.id.to_s
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

  def link
    @attachment = Attachment.find(params['link_id'].gsub(/[^\d]/,''))
    send_file(@attachment.attachment.file.path,
              :filename => @attachment.title,
              :type => @attachment.attachment.file.content_type,
              :disposition => 'attachment',
              :url_based_filename => true)
    # send_file @attachment.attachment.file, :filename => @attachment.title + '.csv', :type => "application/csv"
  end

  private
    def permitted_params
      params.require(:attachment).permit(:title, :description, :attachment)
    end
end
