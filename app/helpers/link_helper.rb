module LinkHelper
  
  # Returns 'delete' link for use on index pages.  Infers id from _url_.
  #
  #   link_to_delete('/foo/1')
  #   link_to_delete(foo_url(1), :label => 'remove', :id => 'my_id', :class => 'my_class')
  #
  #   <a href="/xx/2" class="delete_link" data-confirm="Are you sure?" data-method="delete" id="delete_2" rel="nofollow">
  #     <i class="icon-trash"></i>
  #     Delete
  #   </a>
  def link_to_delete(url, options = {})
    Renderer::Link::Delete.new(self, url, options).html
  end
  
  def link_to_icon_with_text(icon, text, url, options = {})
    options[:class] = Array(options[:class]) << 'with-icon'
    link_to(url, options) do
      icon + content_tag(:b, text)
    end
  end
end