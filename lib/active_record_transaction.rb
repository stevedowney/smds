module ActiveRecordTransaction

	def	transaction
		ActiveRecord::Base.transaction { yield }
	end
	
end