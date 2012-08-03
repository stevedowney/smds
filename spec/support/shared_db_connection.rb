# # Allows specs to run in transactions.
# # See: "Transactions and database setup" at https://github.com/jnicklas/capybara, 
# #
# 
# Rails.logger.error "$spork_prefork: #{$spork_prefork},"
# Rails.logger.error "$spork_each_run: #{$spork_each_run},"
# Rails.logger.error "ENV['DRB']: #{ENV['DRB']}"
# if ($spork_prefork && !ENV['DRB']) || ($spork_each_run && ENV['DRB'])
#   puts 'loading shared_connection'
#   class ActiveRecord::Base
#     mattr_accessor :shared_connection
#     @@shared_connection = nil
# 
#     def self.connection
#       @@shared_connection || retrieve_connection
#     end
#   end
#   ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
# end