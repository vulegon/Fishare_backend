module Api
  module V1
    class SpotsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: [:create]
      # 釣り場を取得します
      # 釣り場の緯度経度をJSONで返します。
      # GET /api/v1/spots
      def index
        search_params = Spots::SearchParameter.new(params)

        spots = SpotFinder.new.search(search_params)

        serialized_spots = Spots::SpotSerializer.new(spots).serialize_spots

        json = {
          message: "釣り場を取得しました",
          spots: serialized_spots,
        }

        render status: :ok, json: json
      end

      # 釣り場を登録します
      # POST api/v1/spots
      def create
        create_params = Spots::CreateParameter.new(params, current_api_v1_user)

        if create_params.invalid?
          render_parameter_error(create_params) and return
        end

        spot = SpotService.create_spot!(create_params)

        json = {
          message: "釣り場を作成しました",
          spot: spot,
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
        editable = if current_api_v1_user
            spot.user_id == current_api_v1_user.id
          else
            false
          end

        json = {
          message: "釣り場の詳細を取得しました",
          name: spot.name,
          description: spot.description,
          location: spot.location.name,
          fish: spot.fish.pluck(:name),
          fishing_types: spot.fishing_types.pluck(:name),
          images: spot.image_urls,
          editable: editable,
        }

        render status: :ok, json: json
      end
    end
  end
end
