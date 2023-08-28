module Api
  module V1
    class SpotsController < ApplicationController
      # 釣り場を取得します
      # 釣り場の緯度経度をJSONで返します。
      # GET /api/v1/spots
      def index
        spots = Spot.all

        serialized_spots = SpotSerializer.new(spots).formatted_data

        json = {
          message: '釣り場を取得しました',
          spots: serialized_spots,
        }

        render status: :ok, json: json
      end

      # 釣り場を登録します
      # POST api/v1/spots
      # @param [Float] latitude 緯度
      # @param [Float] longitude 経度
      # @param [String] user_id ユーザーのID
      # @param option [String] description 釣り場の説明文
      # @param option [Array<ActionDispatch::Http::UploadedFile>] images 釣り場の画像
      def create
        create_params = Spots::CreateParameter.new(params)

        if create_params.invalid?
          render_parameter_error(create_params) and return
        end

        SpotService.create_spot!(create_params)

        json = {
          message: '釣り場を作成しました',
        }

        render status: :ok, json: json
      end

      # 釣り場の詳細を取得します
      # GET api/v1/spots/:id
      # @param [String] id 釣り場のID
      def show
        detail_param = Spots::DetailParameter.new(params)

        if detail_param.invalid?
          render_parameter_error(detail_param) and return
        end

        spot = detail_param.spot
        description = spot.description
        image_urls = spot.image_urls

        json = {
          message: '釣り場の詳細を取得しました。',
          description: description,
          images: image_urls
        }

        render status: :ok, json: json
      end
    end
  end
end
