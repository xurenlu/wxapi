class Wxapi
  module Remark
    # 设置用户备注名
    def remark_user(open_id,remark)
      body = {
        openid: open_id,
        remark: remark
      }.to_json
      access_token = get_access_token
      response = RestClient.post("#{prefix}/cgi-bin/user/info/updateremark?access_token=#{access_token}", body)
      JSON.parse(response)
    end



  end
end
