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
    # @attachment.link = LINK_PREFFIX + @attachment.id.to_s
    if @attachment.save
      # client = Bitly::API::Client.new(token: BITLY_TOKEN)
      # bitlink = client.shorten(long_url: LINK_PREFFIX + @attachment.id.to_s)
      # @attachment.link = bitlink.link
      # @attachment.save
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
    client = Bitly::API::Client.new(token: BITLY_TOKEN)
    @attachment = Attachment.find(params['link_id'].gsub(/[^\d]/,''))
    if @attachment.present?
      bitlink = client.expand(bitlink: @attachment.link)
      send_file(@attachment.attachment.file.path,
                :filename => @attachment.title,
                :type => @attachment.attachment.file.content_type,
                :disposition => 'attachment',
                :url_based_filename => true)
    else
      message = "The file #{@attachment.title} is not present in our system."
      redirect_to attachments_path, notice: message
    end
  end

  private
    def permitted_params
      params.require(:attachment).permit(:title, :description, :attachment)
    end
end
