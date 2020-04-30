class AddLinkToAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :link, :string
  end
end
