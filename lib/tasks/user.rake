namespace :user do
	desc 'Create admin user.  bundle exec rake user:admin_user username=<username> email=<email> password=<password>'
	task :admin_user => [:environment] do
		User.make_admin_user(ENV['username'].dup, ENV['email'].dup, ENV['password'])
	end
	
end