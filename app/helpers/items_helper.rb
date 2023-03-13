module ItemsHelper
  def item_path(item)
    location_item_path(item.location, item)
  end

  def item_breadcrumbs(item)
    root_location = item.ancestors.present? ? item.ancestors.first.location : item.location
    [
      link_to(root_location.name, location_path(root_location)),
      item.ancestors.map { |i| link_to i.name, item_path(i) },
    ].flatten
  end
end
