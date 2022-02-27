module BooksHelper
  def presence_image? book
    image_tag (book.image.attached? ? book.image : "pic1.jpg"),
              class: "img-responsive watch-right", alt: "product"
  end
end
