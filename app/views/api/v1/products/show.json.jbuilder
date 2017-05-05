json.id @product.id
json.title @product.title
json.seller @product.user.first_name
json.description @product.description
json.price @product.price
json.favourites @product.favourites.count

json.reviews @product.reviews do |review|
  json.review_id review.id
  json.review_body review.body
  json.review_likes review.likes.count
end
