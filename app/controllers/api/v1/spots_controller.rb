module Api
  module V1
    class SpotsController < ApplicationController
      def index
        spots = Spot.all

        json = { 
          message: '釣り場を取得しました',
          spots: spots,
        }
        
        render status: :ok, json: json
      end
    end
  end
end
