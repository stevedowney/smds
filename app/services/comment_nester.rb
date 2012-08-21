class CommentNester
  
  attr_accessor :cwas # CommentWithActivity's
  attr_accessor :nested_cwas
  
  def initialize(cwas)
    self.cwas = cwas
  end
  
  def nest_comments
    get_root_comments
    get_nested
    nested_cwas
  end
  
  def get_root_comments
    self.nested_cwas = cwas.select { |cwa| cwa.root? }
  end
  
  def get_nested
    nested_cwas.each do |root_cwa|
      get_children_for(root_cwa)
    end
  end
  
  def get_children_for(node)
    node.child_comments = cwas.select { |cwa| cwa.parent_id == node.comment.id  }
    node.child_comments.each do |child|
      get_children_for(child)
    end
  end
  
  class << self
    
    def nest(cwas)
      new(cwas).nest_comments
    end
    
  end
  
end