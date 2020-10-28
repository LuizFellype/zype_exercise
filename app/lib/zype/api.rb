module Zype
  class Api
    def self.get(path, params)
      url = "#{ENV['ZYPE_API_ENDPOINT']}/#{path}"

      response = RestClient.get(url, params: params)
      result = JSON.parse(response.body)
      raise ApiCallFailed, result.message if response.code != 200

      result['response']
    end

    def self.post(path, params)
      url = "#{ENV['ZYPE_API_ENDPOINT']}/#{path}"
      header = {
        content_type: :json
      }
      response = RestClient.post(url, params, header)
      result = JSON.parse(response.body)
      raise AuthenticationFailed, result.message if result.code != 200
      result
    end
  end
end
