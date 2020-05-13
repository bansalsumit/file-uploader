class Attachment < ApplicationRecord
  mount_base64_uploader :attachment, AttachmentUploader
  belongs_to :user
end
