class Api::V1::PostsController < ApplicationController

  def index
    json = { message: '通信できているよ！' }
    render status: :ok, json: json
  end
end
