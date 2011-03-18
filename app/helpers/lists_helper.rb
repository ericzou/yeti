module ListsHelper
  def list_items_blank?(list)
    list.errors.on(:list_items).blank? and list.errors.on("list_items.body").blank? ? false : true
  end
end
