# https://gist.github.com/362873

namespace :heroku do

  desc "Deploy to heroku"
  task :deploy => [:push, :curl] do
    puts 
    puts 'Pushing code'
  end

  desc "Deploy to heroku with database migration"
  task :deploy_with_migration => [:push, :off, :migrate, :on, :curl] do
    puts 'deploy with migration'
  end

  task :push do
    puts 'Deploying site to Heroku ...'
    puts `git push heroku master`
  end

  task :migrate do
    puts 'Running database migrations ...'
    puts `heroku run rake db:migrate`
  end

  task :off do
    puts 'Putting the app into maintenance mode ...'
    puts `heroku maintenance:on`
  end

  task :on do
    puts 'Taking the app out of maintenance mode ...'
    puts `heroku maintenance:off`
  end

  task :curl do
    puts 'Curling site'
    `curl hewasall.com`
    puts 'Site should be live ...'
  end
  
end