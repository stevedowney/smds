class Class
  
  # Foo::BarBaz.underscore => "foo_bar_baz"
  def underscore
    self.name.to_s.underscore.tr('/', '_')
  end
  
  # Foo::BarBaz.demodulize_underscore #=> "bar_baz"
  def demodulize_underscore
    self.name.to_s.demodulize.underscore
  end
  
end