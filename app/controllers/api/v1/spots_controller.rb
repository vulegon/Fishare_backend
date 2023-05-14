module Api
  module V1
    class SpotsController < ApplicationController
      # 釣り場一覧を取得します
      # GET /api/v1/spots
      def index
        spots = Spot.all

        json = { 
          message: '釣り場を取得しました',
          spots: spots,
        }
        
        render status: :ok, json: json
      end

      # 釣り場を登録します
      # POST /api/v1/spots
      # @param [Float] latitude 緯度
      # @param [Float] longitude 経度
      # @param option [String] description 釣り場の説明文
      # @param option [Array<ActionDispatch::Http::UploadedFile>] images 釣り場の画像
      # @return [JSON] 実行結果
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
    end
  end
end
