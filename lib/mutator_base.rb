class MutatorBase
  include ActiveRecordTransaction
  
  class NoUserError < StandardError; end
  class SuccessCalledBeforeMutatorCalledError < StandardError; end
  
  attr_accessor :user, :success
  
  def initialize(user)
    self.user = user.presence or raise(NoUserError, "need a user")
  end
  
  def success?
    if success.nil?
      raise SuccessCalledBeforeMutatorCalledError
    else
      success
    end
  end
  
  def admin?
    user.admin?
  end
  
  def not_admin?
    !admin?
  end
  
end

