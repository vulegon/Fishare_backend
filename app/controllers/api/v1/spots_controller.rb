module Api
  module V1
    class SpotsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: [:create, :destroy, :update]

      # 釣り場を取得します
      def index
        spots = Spot.all
        serialized_spots = Spots::IndexSerializer.new(spots).serialize_spots

        json = {
          message: "釣り場を取得しました",
          spots: serialized_spots,
        }

        render status: :ok, json: json
      end

      # 釣り場を検索します
      def search
        search_params = Spots::SearchParameter.new(params)

        if search_params.invalid?
          render_parameter_error(search_params) and return
        end

        spots = ::Spots::SpotFinder.new.search(search_params)

        serialized_spots = Spots::SpotSerializer.new(spots).serialize_spots

        json = {
          message: "釣り場を検索しました",
          spots: serialized_spots,
        }

        render status: :ok, json: json
      end

      # 釣り場を登録します
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
      def show
        detail_param = Spots::DetailParameter.new(params)

        if detail_param.invalid?
          render_parameter_error(detail_param) and return
        end

        spot = detail_param.spot

        serialized_spots = Spots::ShowSerializer.new(spot, current_api_v1_user).serialize_spots

        json = {
          message: "釣り場の詳細を取得しました",
          spot: serialized_spots
        }

        render status: :ok, json: json
      end

      # 釣り場を更新します
      def update
        update_params = Spots::UpdateParameter.new(params, current_api_v1_user)

        if update_params.invalid?
          render_parameter_error(update_params) and return
        end

        SpotService.update_spot!(update_params)

        json = {
          message: "釣り場を更新しました",
        }

        render status: :ok, json: json
      end

      # 釣り場を削除します
      def destroy
        destroy_params = Spots::DestroyParameter.new(params, current_api_v1_user)

        if destroy_params.invalid?
          render_parameter_error(destroy_params) and return
        end

        SpotService.destroy_spot!(destroy_params)

        json = {
          message: "釣り場を削除しました",
        }

        render status: :ok, json: json
      end
    end
  end
end
