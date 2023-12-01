class SpotService
  class << self
    # 釣り場を作成します
    # @param params[<Spots::CreateParameter>] 釣り場作成のパラメータ
    # @return void
    def create_spot!(params)
      ActiveRecord::Base.transaction do
        user = params.user

        # spotモデルの更新
        spot = user.spots.create!(params.model_attributes)

        # 関連データの作成
        params.fish_record.each do |fish|
          spot.catchable_fishes.create!(fish_id: fish.id)
        end

        fishing_types = params.fishing_types_record
        fishing_types.each do |fifishing_type|
          spot.spot_fishing_types.create!(fishing_type_id: fifishing_type.id)
        end
      end
    end

    # 釣り場を削除します
    # @param params[<Spots::DestroyParameter>] 釣り場削除のパラメータ
    # @return void
    def destroy_spot!(params)
      ActiveRecord::Base.transaction do
        spot = params.spot
        spot.destroy!
      end
    end

    # 釣り場を更新します
    # @param params[<Spots::UpdateParameter>] 釣り場削除のパラメータ
    # @return void
    def update_spot!(params)
      spot = params.spot

      diff_update_attributes = calculate_update_diff(spot, params.model_attributes)

      ActiveRecord::Base.transaction do
        spot.catchable_fishes.destroy_all
        spot.spot_fishing_types.destroy_all

        if diff_update_attributes.present?
          spot.assign_attributes(diff_update_attributes)
          spot.save!
        end

        # 関連モデルの更新
        params.fish_record.each do |fish|
          spot.catchable_fishes.create!(fish_id: fish.id)
        end

        params.fishing_types_record.each do |fifishing_type|
          spot.spot_fishing_types.create!(fishing_type_id: fifishing_type.id)
        end
      end
    end

    private

    def calculate_update_diff(spot, params)
      params.reject { |key, value| spot[key] == value }
    end
  end
end
