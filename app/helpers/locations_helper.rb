module LocationsHelper
  def location_breadcrumbs(location)
    locations = location.ancestors + [location]
    locations.each_with_object({}) { |l, h| h[l.name] = location_path(l) }
  end
end
