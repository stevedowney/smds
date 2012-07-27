# # Allows specs to run in transactions.
# # See: "Transactions and database setup" at https://github.com/jnicklas/capybara, 
# #
# class ActiveRecord::Base
#   mattr_accessor :shared_connection
#   @@shared_connection = nil

#   def self.connection
#     @@shared_connection || retrieve_connection
#   end
# end
# ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection