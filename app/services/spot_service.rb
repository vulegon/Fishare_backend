class SpotService
  class << self
    # 釣り場を作成します
    # @param params[<Spots::CreateParameter>] 釣り場作成のパラメータ
    # @return void
    def create_spot!(params)
      spot = Spot.new(params.model_attributes)
      spot.save!
    end
  end
end

