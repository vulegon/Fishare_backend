module Spots
  class SearchSerializer < ActiveModel::Serializer
    attr_reader :relation

    attributes :spots

    def initialize(relation)
      super(relation)
      @relation = relation
    end

    def spots
      ActiveModel::Serializer::CollectionSerializer.new(
        relation,
        serializer: ::Spots::SpotSerializer,
        cache_locations: location_by_spot_id,
        cache_fish: fish_by_spot_id,
        cache_fishing_types: fishing_types_by_spot_id,
      ).as_json
    end

    private

    # @return [Hash] { 'spot_id' => 'location_name', ... }
    def location_by_spot_id
      relation.joins(:location).pluck(:id, "locations.name").to_h
    end

    # @return [Hash] { 'spot_id' => [fish_name, ...], ... }
    def fish_by_spot_id
      relation.joins(:fish).pluck(:id, "fish.name").
        each_with_object({}) do |(spot_id, fish_name), hash|
        hash[spot_id] ||= []
        hash[spot_id] << fish_name
      end
    end

    # @return [Hash] { 'spot_id' => [fishing_type_name, ...], ... }
    def fishing_types_by_spot_id
      relation.joins(:fishing_types).pluck(:id, "fishing_types.name").
        each_with_object({}) do |(spot_id, fishing_type), hash|
        hash[spot_id] ||= []
        hash[spot_id] << fishing_type
      end
    end
  end
end
