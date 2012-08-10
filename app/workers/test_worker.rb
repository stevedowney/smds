class TestWorker
  include Sidekiq::Worker
  # sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def perform(user_id)
    user = User.find(user_id)
    File.open(Rails.root.join('tmp/', user_id.to_s), "w") do |f|
      f.puts user.username
    end
  end
end