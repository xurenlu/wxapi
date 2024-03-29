require "wxapi/version"
require "wxapi/menu"
require "wxapi/kf_message"
require "wxapi/templet_message"
require "wxapi/access_token"
require "wxapi/account"
require "wxapi/aes"
require "wxapi/utils"
require "wxapi/user"
require "wxapi/material"
require 'rest-client'
require 'wxapi/attach'
require 'wxapi/tag'
require 'wxapi/remark'
require 'wxapi/misc'
class Wxapi



  include AccessToken
  include Account
  include Aes
  include Kf
  include Material
  include Menu
  include Tp
  include User
  include Utils
  include Attach
  include Tag
  include Remark
  include Misc

  # 默认不缓存 access_token, access_token_cache = True 缓存
  # @param <hash> aoptions
  # => example
  # wechat_api = WechatPublicApi.new appid: 'xx', app_secret: 'xx', access_token_cache: true
  # wechat_api.app_id -- get appid
  #
  #  api.get_access_token
  #
  attr_accessor :app_id, :app_secret, :access_token_cache
  attr_accessor :prefix
  def initialize(options={})
    @app_id = options[:app_id]
    @app_secret = options[:app_secret]
    @access_token_cache = options[:access_token_cache]
    @prefix = options[:prefix]
    @prefix="https://api.weixin.qq.com" if @prefix.nil?
  end


  private
  def test_resp(resp)
    if resp['errcode'] != 0
      raise "Error: #{resp['errmsg']}"
    end
    resp
  end
end
