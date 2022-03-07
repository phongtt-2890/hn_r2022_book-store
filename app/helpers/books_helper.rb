module BooksHelper
  def presence_image? book
    if book.image.attached?
      image_tag book.image, class: "img-responsive watch-right"
    else
      image_tag("pic1.jpg",
                alt: "product",
                class: "img-responsive watch-right")
    end
  end
end
