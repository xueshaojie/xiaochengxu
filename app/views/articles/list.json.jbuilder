json.articles @articles do |article|
  json.id article.id
  json.title article.title
  json.text article.text
  json.category_name article.category_name
  json.status_name article.status_name
  # json.user.email article.user.email.to_s
end
