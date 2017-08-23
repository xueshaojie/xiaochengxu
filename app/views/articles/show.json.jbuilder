json.article do
  json.id @article.id
  json.title @article.title
  json.created_at @article.created_at 
  json.text @article.text
end
