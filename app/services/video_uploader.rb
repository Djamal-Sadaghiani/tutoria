require "google/cloud/storage"

class VideoUploader

  def perform(tutorial , file)
    filename = DateTime.now.strftime('%Q') + file
    storage_bucket
    file = @storage_bucket.create_file "./app/assets/images/#{file}", filename
    return file
  end

  private

  def storage_bucket
    @storage_bucket ||= begin
      config = Rails.application.config.x.settings
      storage = Google::Cloud::Storage.new project_id: config["project_id"],
                                           credentials: config["keyfile"]
      storage.bucket config["gcs_bucket"]
    end
  end
end
