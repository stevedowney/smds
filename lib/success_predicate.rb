module SuccessPredicate
  
  # Raised when #success?  is called before the #success attribute is set
  class CalledEarlyError < StandardError; end
  
  attr_accessor :success
  
  def success?
    if success.nil?
      raise SuccessCalledBeforeMutatorCalledError
    else
      success
    end
  end
  
end