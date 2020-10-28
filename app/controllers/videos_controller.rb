class VideosController < ApplicationController
  before_action :authenticate_user!, only: :show

  def index
    @videos = Zype::Video.all(current_user)
  end
end
