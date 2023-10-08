class SpotService
  class << self
    # 釣り場を作成します
    # @param params[<Spots::CreateParameter>] 釣り場作成のパラメータ
    # @return void
    def create_spot!(params)
      ActiveRecord::Base.transaction do
        user = params.user
        spot = user.spots.create!(params.model_attributes)

        params.fish_record.each do |fish|
          spot.catchable_fishes.create!(fish_id: fish.id)
        end

        fishing_types = params.fishing_types_record
        fishing_types.each do |fifishing_type|
          spot.spot_fishing_types.create!(fishing_type_id: fifishing_type.id)
        end
      end
    end
  end
end
