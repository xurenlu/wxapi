class Wxapi
  module Attach
    def upload_temp_image(file_path,type='image')
      access_token = get_access_token
      response = RestClient.post("#{prefix}/cgi-bin/media/upload",
                                 {
                                     access_token: access_token,
                                     type: type,
                                     media: File.new(file_path, 'rb')})
      JSON.parse(response)
    end
  end
end
