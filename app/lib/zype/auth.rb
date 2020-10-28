module Zype
  class Auth
    def self.login(username, password)
      url = ENV['ZYPE_OAUTH_ENDPOINT']
      params = {
        username: username,
        password: password,
        client_id: ENV['ZYPE_CLIENT_ID'],
        client_secret: ENV['ZYPE_CLIENT_SECRET'],
        grant_type: 'password'
      }
      header = {
        content_type: 'application/x-www-form-urlencoded'
      }

      result = RestClient.post(url, params, header)
      body = JSON.parse(result.body)
      raise AuthenticationFailed, body.message if result.code != 200

      body
    rescue RestClient::Unauthorized => e
      raise AuthenticationFailed, e.message
    end
  end

  class AuthenticationFailed < StandardError; end
end
