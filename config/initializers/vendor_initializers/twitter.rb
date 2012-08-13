TwitterProxy = Rails.env == 'test' ? TestTwitter : Twitter

Twitter.configure do |config|
  config.consumer_key = 'fAGWu4yc3lpJK4hNE7n3A'
  config.consumer_secret = 'CO6QIIiJBT6FfTYUbZXpRJCud0D45jc0JrSQNWlqZE'
  config.oauth_token = '751954266-9YguapFQiSM8UsWuN2HY2erDOAZNqeglugU8M25J'
  config.oauth_token_secret = 'S1V2wxIH7gvA8udLpxc0pBrC5k2kXj3RtsvAUqSOfpk'
end