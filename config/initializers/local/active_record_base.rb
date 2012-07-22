class ActiveRecord::Base
	include ActionController::RecordIdentifier

  def dom_id(*args)
    super(self, *args)
  end
  
end