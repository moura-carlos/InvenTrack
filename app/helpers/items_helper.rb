module ItemsHelper
  def main_image(item)
    if item.main_image.attached?
      image_tag item.main_image, class: "card-img-top object-fit-cover", alt: item.title
    else
      image_tag "placeholder.jpg", class: "card-img-top object-fit-cover", alt: item.title
    end
  end
end
