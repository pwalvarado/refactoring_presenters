json.array!(@news_posts) do |news_post|
  json.extract! news_post, :id, :title, :content, :user_id
  json.url news_post_url(news_post, format: :json)
end
