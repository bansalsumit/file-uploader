class Attachment < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
end
