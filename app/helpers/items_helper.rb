module ItemsHelper
  def item_path(item)
    location_item_path(item.location, item)
  end

  def item_breadcrumbs(item)
    location = item.ancestors.present? ? item.ancestors.first.location : item.location
    hash = location_breadcrumbs(location)
    item.ancestors.each_with_object(hash) { |i, h| h[i.name] = item_path(i) }
  end
end
