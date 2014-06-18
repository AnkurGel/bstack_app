class Upload < ActiveRecord::Base
  before_destroy :destroy_uploaded_file

  mount_uploader :file, FileUploader

  belongs_to :user

  validates :user_id, presence: true
  
  private
  def destroy_uploaded_file
    File.delete(self.file.path)
  end
end

