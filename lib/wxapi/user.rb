#####################################################
# 公众号用户管理
# Created by zhangmingxin
# Date: 2018-05-18
# Wechat number: zmx119966
####################################################

class Wxapi
  module User
    # 获取用户信息
    # @return <JSON>
    # {
    #     "subscribe": 1,
    #     "openid": "o6_bmjrPTlm6_2sgVt7hMZOPfL2M",
    #     "nickname": "Band",
    #     "sex": 1,
    #     "language": "zh_CN",
    #     "city": "广州",
    #     "province": "广东",
    #     "country": "中国",
    #     "headimgurl":"http://thirdwx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0",
    #     "subscribe_time": 1382694957,
    #     "unionid": " o6_bmasdasdsad6_2sgVt7hMZOPfL"
    #     "remark": "",
    #     "groupid": 0,
    #     "tagid_list":[128,2],
    #     "subscribe_scene": "ADD_SCENE_QR_CODE",
    #     "qr_scene": 98765,
    #     "qr_scene_str": ""
    # }
    #
    # if failed
    # {"errcode":40013,"errmsg":"invalid appid"}
    #
    def get_userinfo(openid)
      # request access_token
      access_token = get_access_token
      JSON.parse RestClient.get("#{prefix}/cgi-bin/user/info?access_token=#{access_token}&openid=#{openid}&lang=zh_CN").body
    end

    # 获取公众号的黑名单列表
    def user_list(next_openid = '')
      access_token = get_access_token
      JSON.parse RestClient.get("#{prefix}/cgi-bin/user/get?access_token=#{access_token}&next_openid=#{next_openid}").body
    end

    # 批量获取用户基本信息
    # 最多支持一次拉取100条。
    def batch_user_detail(openid_list=[],lang="zh_CN")

      raise 'openid_list is empty' if openid_list.empty?
      raise 'openid_list is too long' if openid_list.length > 100


      user_list = []
      openid_list.each do |openid|
        user_list << {openid: openid, lang: lang}
      end
      access_token = get_access_token
      JSON.parse RestClient.post("#{prefix}/cgi-bin/user/info/batchget?access_token=#{access_token}", {user_list: user_list}.to_json)
    end

    # 2. 拉黑用户
    def get_black_list()
      access_token = get_access_token
      JSON.parse RestClient.post("#{prefix}/cgi-bin/tags/members/getblacklist?access_token=#{access_token}", {begin_openid: ''}.to_json)
    end

    def batch_black_list(openid_list=[])
      access_token = get_access_token
      JSON.parse RestClient.post("#{prefix}/cgi-bin/tags/members/batchblacklist?access_token=#{access_token}", {openid_list: openid_list}.to_json)
    end

    #3. 取消拉黑用户
    def batchunblacklist(openid_list=[])
      access_token = get_access_token
      JSON.parse RestClient.post("#{prefix}/cgi-bin/tags/members/batchunblacklist?access_token=#{access_token}", {openid_list: openid_list}.to_json)
    end
  end
end
