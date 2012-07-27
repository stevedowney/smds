module VotingSummaryMethods

  def update_votes!(vote_delta)
    self.vote_up_count += vote_delta.up
    self.vote_down_count += vote_delta.down
    self.vote_net_count = vote_up_count - vote_down_count
    save!
  end

end