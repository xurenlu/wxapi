require './lib/wxapi'
require 'redis'
require 'rest-client'
require 'json'
$redis = Redis.new(url: "redis://localhost:6379/0")
$we_api = Wxapi.new app_id: 'wx3b8fe6d36cc00e3e',
                    app_secret: 'e6755d03d7f58b71aac8c22f6271c265',
                    access_token_cache: false,
                    api_prefix: 'https://proxy.biying88.cn/proxywx'

puts $we_api.get_access_token
