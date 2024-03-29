#####################################################
# 公众号自定义菜单栏模块 (about wechat public menu)
# Created by zhangmingxin
# Date: 2018-05-17
# Wechat number: zmx119966
####################################################

class Wxapi
  module Menu
    ###
    # create wechat public menu
    # @param <json> post_data
    #
    # =>  post_data example
    # {
    # 	  "button": [
    #     {
    #  		 "type": "view",
    #  		 "name": "",
    #  		 "url": "",
    #  		 "sub_button": []
    #  	  },
    #     {
    #  		 "type": "click",
    #  		 "name": "",
    #  		 "key": "menu_3",
    #  		 "sub_button": []
    #  	  }
    #   ]
    # }
    #
    # if success
    # @return <JSON> {"errcode"=>0, "errmsg"=>"ok"}
    # if failed
    # @return <JSON> {"errcode"=>40166, "errmsg"=>"...."}
    #
    def create_menu(post_data)
      # request access_token
      access_token = get_access_token()
      post_data = post_data.to_json.gsub(/\\u([0-9a-z]{4})/) {|s| [$1.to_i(16)].pack("U")}

      uri = URI.parse("#{prefix}/cgi-bin/menu/create?access_token=#{access_token}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new("/cgi-bin/menu/create?access_token=#{access_token}")
      request.add_field('Content-Type', 'application/json')
      request.body = post_data
      response = http.request(request)
      (JSON.parse response.body)
    end

    # get wechat public menu list
    def query_menu()
      # request access_token
      access_token = get_access_token()
      response = RestClient.get("#{prefix}/cgi-bin/menu/get?access_token=#{access_token}").body
      (JSON.parse response)
    end

    ###
    # delete wechat query from access_token
    # @return <JSON> {"errcode"=>0, "errmsg"=>"ok"}
    #
    def delete_menu()
      # request access_token
      access_token = get_access_token
      response = RestClient.get("#{prefix}/cgi-bin/menu/delete?access_token=#{access_token}").body
      (JSON.parse response)
    end
  end
end
