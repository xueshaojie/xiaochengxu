json.articles @articles do |article|
  json.id article.id
  json.title article.title
  json.text article.text
  json.category_name article.category_name
  json.author article.user.wx_user.nickName
  json.created_at article.created_at
end
