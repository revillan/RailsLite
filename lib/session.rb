require 'json'
require 'byebug'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    # debugger
    cookies = req.cookies.select { |k, _| k == "_rails_lite_app"}
    if cookies.empty?
      @cook = {}
    else
      @cook = JSON.parse(cookies.first[1]) || {}
    end
  end

  def [](key)
    @cook[key]
  end

  def []=(key, val)
    @cook[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    # debugger
    res.set_cookie("_rails_lite_app", {path: "/", value: @cook.to_json})
  end
end
