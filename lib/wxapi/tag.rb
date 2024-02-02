class Wxapi
  module Tag

    # 1. 创建标签
    #
    # 一个公众号，最多可以创建100个标签。
    def new_tag(name="")
      body = {
        tag:{
          name: name
        }
      }.to_json
      access_token = get_access_token
      response = RestClient.post("#{prefix}/cgi-bin/tags/create?access_token=#{access_token}", body)
      JSON.parse(response)
    end

    # 获取公众号已创建的标签
    # 返回说明
    #
    # {
    # "tags":[{
    #     "id":1,
    #     "name":"每天一罐可乐星人",
    #     "count":0 //此标签下粉丝数
    # },
    # {
    #     "id":2,
    #     "name":"星标组",
    #     "count":0
    # }]}
    def tags
      access_token = get_access_token
      response = RestClient.get("#{prefix}/cgi-bin/tags/get?access_token=#{access_token}")
      JSON.parse(response)
    end

    def update_tag(id=0,name="")
      body = {
        tag:{
          id: id,
          name: name
        }
      }.to_json
      access_token = get_access_token
      response = RestClient.post("#{prefix}/cgi-bin/tags/update?access_token=#{access_token}", body)
      JSON.parse(response)
    end

    # 删除标签
    # 一个标签下的粉丝列表不会自动删除
    # 删除标签后，所有该标签下的粉丝会取消标签的标记。
    def delete_tag(id)
      body = {
        tag:{
          id: id
        }
      }.to_json
      access_token = get_access_token
      response = RestClient.post("#{prefix}/cgi-bin/tags/delete?access_token=#{access_token}", body)
      JSON.parse(response)

    end


    # 批量为用户打标签

    def tag_users(tagid,openid_list)
      body = {
        openid_list: openid_list
      }.to_json
      access_token = get_access_token
      response = RestClient.post("#{prefix}/cgi-bin/tags/members/batchtagging?access_token=#{access_token}", body)
      JSON.parse(response)
    end

    #获取标签下粉丝列表
    #
    def users_of_tags(tagid,next_openid="")
      body = {
        tagid: tagid,
        next_openid: next_openid
      }.to_json
      access_token = get_access_token
      response = RestClient.post("#{prefix}/cgi-bin/user/tag/get?access_token=#{access_token}", body)
      JSON.parse(response)
    end

    # 批量为用户取消标签
    def untag_users(tagid,openid_list=[])
      raise "openid_list is empty" if openid_list.empty?
      raise 'tagid is empty' if tagid == 0
      raise 'size of openid_list is more than 50' if openid_list.size > 50

      body = {
        openid_list: openid_list
      }.to_json
      access_token = get_access_token
      response = RestClient.post("#{prefix}/cgi-bin/tags/members/batchuntagging?access_token=#{access_token}", body)
      JSON.parse(response)
    end


    #  获取用户身上的标签列表
    def tags_of_user(open_id)
      body = {
        openid: open_id
      }.to_json
      access_token = get_access_token
      response = RestClient.post("#{prefix}/cgi-bin/tags/getidlist?access_token=#{access_token}", body)
      JSON.parse(response)
    end


  end
end
