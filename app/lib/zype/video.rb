module Zype
  class Video
    def self.all(options = {})
      params = {
        sort: 'created_at',
        order: 'desc',
        app_key: ENV['ZYPE_APP_KEY']
      }

      Zype::Api.get('/videos', params)
    end
  end
end
