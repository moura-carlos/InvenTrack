module ItemsHelper
  def main_image(item)
    if item.main_image.attached?
      image_tag @item.main_image
    else
      image_tag "placeholder.jpg"
    end
  end
end
