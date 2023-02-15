module ItemsHelper
  def item_path(item)
    location_item_path(item.location, item)
  end
end
