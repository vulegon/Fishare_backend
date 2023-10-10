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
    Spot.all.valid
  end

  def by_spot_name(query, name)
    return query if name.blank?
    query.where("spots.name LIKE ?", "%#{sanitize_sql_like(name)}%")
  end

  def by_spot_location(query, location_name)
    return query if location_name.blank?
    query.joins(:location).where(locations: { name: location_name })
  end

  def by_catchable_fish(query, fish_names)
    return query if fish_names.blank?
    query.joins(:fish).where(fish: { name: fish_names })
  end

  def by_fishing_types(query, fishing_type_names)
    return query if fishing_type_names.blank?
    query.joins(:fishing_types).where(fishing_types: { name: fishing_type_names })
  end

  def sort_by(spots)
    spots.order(created_at: :desc, name: :asc, id: :asc)
  end
end
