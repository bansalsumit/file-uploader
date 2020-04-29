class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.string :title
      t.string :description
      t.string :attachment

      t.timestamps
    end
  end
end
