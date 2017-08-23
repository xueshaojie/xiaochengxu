json.articles @articles do |article|
  json.id article.id
  json.title article.title
  json.text article.text
  json.category article.category
  json.status article.status
  # json.user.email article.user.email
end
