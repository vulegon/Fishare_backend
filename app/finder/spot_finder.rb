class SpotFinder
  def search(search_params)
    sort_by(filter_spots(search_params))
  end

  private

  def filter_spots(search_params)
    query = base_query
    query = by_spot_name(query, search_params.name)
    query = by_spot_location(query, search_params.location)
    query = by_catchable_fish(query, search_params.fish)
    query = by_fishing_types(query, search_params.fishing_types)

    query
  end

  def base_query
    Spot.valid.all
  end

  def by_spot_name(query, name)
    return query if search_params.name.blank?
    query.where("spots.name LIKE ?", "%#{sanitize_sql_like(name)}%")
  end

  def by_spot_location(query, location_name)
    return query if search_params.location.blank?
    query.joins(:location).where(locations: { name: search_params.location })
  end

  def by_catchable_fish(query)
    return query if search_params.fish.blank?
    query.joins(:fish).where(fish: { name: search_params.fish })
  end

  def by_fishing_types(query)
    return query if search_params.fishing_types.blank?
    query.joins(:fishing_types).where(fishing_types: { name: search_params.fishing_types })
  end

  def sort_by(spots)
    spots.order(created_at: :desc, name: :asc, id: :asc)
  end
end
