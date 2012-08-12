module VotingDetailMethods

  def toggle_vote_up!
    self.voted_up = !voted_up
    self.voted_down = false
    result = vote_delta
    save!
    result
  end

  def toggle_vote_down!
    self.voted_down = !voted_down
    self.voted_up = false
    result = vote_delta
    save!
    result
  end

  def vote_delta
    up_change = if voted_up_changed?
      voted_up? ? 1 : -1
    else
      0
    end

    down_change = if voted_down_changed?
      voted_down? ? 1 : -1
    else
      0
    end

    VoteDelta.new(up_change, down_change)
  end

end