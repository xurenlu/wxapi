class Wxapi
  module Misc
  def api_quota(cgi_path)
    access_token = get_access_token
    response = RestClient.post("#{prefix}/cgi-bin/openapi/quota/get?access_token=#{access_token}", {cgi_path: cgi_path}.to_json, {content_type: :json, accept: :json})
    JSON.parse(response)
  end

  def code2session(code)
    response = RestClient.get("#{prefix}/sns/jscode2session?appid=#{@app_id}&secret=#{@app_secret}&js_code=#{code}&grant_type=authorization_code")
    resp = JSON.parse(response)
    test_resp resp
  end
  end
end
