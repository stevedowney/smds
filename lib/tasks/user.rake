namespace :user do
  
	desc 'Create admin user.  bundle exec rake user:admin_user username=<username> email=<email> password=<password>'
	task :admin_user => [:environment] do
	  username = ENV['username'].to_s.dup
	  email = ENV['email'].to_s.dup
	  password = ENV['password'].to_s.dup
		CreatesUsers.create_or_update_admin_user(username, email, password)
	end
	
end